function phase_create_area(j)
  create_job_area(j)
end

function phase_map(j)
  info("initiating mapping phase")
  wrkrs = workers()
  r = [@spawnat w runmapper(j) for w in wrkrs]
  for ri in r
    wait(ri)
  end
  info("mapping phase finished")
end

function runmapper(j)
  info("map worker $(myid()) initiated")
  inputfile = joinpath(splitdir, string(myid()), j.input_filename)
  io_input = open(inputfile)
  io_output = write_sink(j, "map")
  for (linenum, line) in enumerate(eachline(io_input))
    try
      v = json(j.mapper(line))
      write(io_output, v * "\n")
    catch e
      if typeof(e) in [MapperException, UDFException]
        warn("[JOB $(j.jobid)] mapper encountered an exception of type $(typeof(e)) on line $(linenum): $(e.msg)")
      else
        rethrow(e)
      end
    end
  end
  close(io_input)
  close(io_output)
  info("map worker $(myid()) finished")
  return true
end

function phase_reduce(j)
  wrkrs = workers()
  r = [@spawnat w runreducer(j) for w in wrkrs]
  for ri in r
    wait(ri)
  end
end

function runreducer(j)
  debug("reducer $(myid()) initiated")

  io_input = read_sink(j, "map")
  io_output = write_sink(j, "reduce")

  # this reads the input lines into memory and passes them to the reducer
  # perhaps it's better to pass line by line, freeing previous lines, and let the reducer keep track of them internally if necessary?
  write(io_output, json(j.reducer(readlines(io_input))))

  close(io_input)
  close(io_output)

  debug("reducer $(myid()) finished")
  return true
end

function phase_combine(j)
  wrkrs = workers()
  last_output_phase = last_output_phase_before_combiner(j)
  r = [@spawnat w read_sink_lines(j, last_output_phase) for w in wrkrs]
  combined = []
  for i = 1:length(r)
    wait(r[i])
    append!(combined, fetch(r[i]))
  end
  combined_output = j.combiner(combined)
  return combined_output
end
