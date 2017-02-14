function phase_create_area(j)
  create_job_area(j)
end

function phase_run(j)
  info("initiating run phase")
  r = [@spawnat w runfun(j) for w in workers()]
  map(wait, r)
  info("run phase finished")
end

function runfun(j)
  info("runfun worker $(myid()) initiated")
  length(j.inputs) > 2 && throw(ArgumentError("Cannot operate on more than two inputs."))
  length(j.inputs) == 1 && runfuni1(j)
  length(j.inputs) == 2 && runfuni2(j)
  info("runfun worker $(myid()) finished")
end

function runfuni1(j)
  info("runfuni1 $(myid()) initiated")
  input_filename = j.inputs[1]
  inputfile = joinpath(splitdir, string(myid()), input_filename)
  io_input = open(inputfile)
  io_output = write_sink(j)
  for (linenum, line) in enumerate(eachline(io_input))
    try
      v = j.fun(line)
      v != "" && write(io_output, json(v) * "\n")
    catch e
      if typeof(e) in [MapperException, UDFException]
        warn("[JOB $(j.jobid)] mapper encountered an exception of type $(typeof(e)) on line $(linenum): $(e.msg)")
      else
        rethrow(e)
      end
    end
  end

  if length(ctx) > 0
    for (k, v) in ctx
      write(io_output, json((k, v)) * "\n")
    end
  end
  close(io_input)
  close(io_output)
  info("runfuni1 $(myid()) finished")
end

function runcombiner(filename, fun_combiner)
  r = [@spawnat w readlines(joinpath(splitdir, string(w), filename)) for w in workers()]
  combined = []
  map(wait, r)
  for p in r
    append!(combined, fetch(p))
  end
  fun_combiner(combined)
end
