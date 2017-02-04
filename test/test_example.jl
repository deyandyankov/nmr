facts("test_example") do
  j = nmr.NMR(1, "Top30_airports_LatLong.csv", nmr.mapper_example, nmr.reducer_example, nmr.combiner_example)
  output = nmr.runjob(j)

  @fact sum([parse(chomp(s)) for s in output]) --> 31
end
