# addprocs(4)

using FactCheck
using JSON
using nmr

cd(joinpath(Pkg.dir("nmr"), "test")) do
  testfiles = [f for f in readdir(".") if isfile(f) && startswith(f, "test_") && endswith(f, ".jl")]
  function run_test(testfile)
    info("Running test file $(testfile)")
    include(testfile)
  end
  map(run_test, testfiles)
end
