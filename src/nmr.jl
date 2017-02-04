"""
nmr - Naive MapReduce module

NMR is a Naive MapReduce implementation.
It has a simple interface that allows the user to input a filename and process it in a map-reduce fashion.
"""
module nmr
  pkgdir = Pkg.dir("nmr")
  datadir = "NMR_DATADIR" in keys(ENV) ? ENV["NMR_DATADIR"] : joinpath(pkgdir, "test", "data")
  splitdir = "NMR_SPLITDIR" in keys(ENV) ? ENV["NMR_SPLITDIR"] : joinpath(pkgdir, "test", "split")
  outputdir = "NMR_OUTPUTDIR" in keys(ENV) ? ENV["NMR_OUTPUTDIR"] : joinpath(pkgdir, "test", "output")

  # required for correct module operation
  include("logging_config.jl")
  include("types.jl")
  include("io.jl")
  include("phases.jl")

  # user defined functions and types
  include("udf/types.jl")
  include("udf/mappers.jl")
  include("udf/reducers.jl")
  include("udf/combiners.jl")

  function runjob(j)
    info("Running job: $j")
    split_raw_data(j.input_filename)
    phase_create_area(j)
    phase_map(j)
    phase_reduce(j)
    output = phase_combine(j)
    return output
  end

end # module
