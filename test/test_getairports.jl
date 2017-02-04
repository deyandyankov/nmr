workspace()
reload("nmr")
j = nmr.NMR(2, "Top30_airports_LatLong.csv", nmr.mapper_getairports, nmr.reducer_getairports, nmr.combiner_getairports)
output = nmr.runjob(j)



# facts("test_getairports") do
#   reload("nmr")
#   j = nmr.NMR(2, "Top30_airports_LatLong.csv", nmr.mapper_getairports, nmr.reducer_getairports, nmr.combiner_getairports)
#   output = nmr.runjob(j)
#
#   @fact is(typeof(output), Array{Any, 1}) --> true
#   # @fact sum([parse(chomp(s)) for s in output]) --> 3
# end
