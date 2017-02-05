reload("nmr")
j = nmr.NMR(2, "Top30_airports_LatLong.csv", nmr.mapper_getairports, nmr.reducer_getairports, nmr.combiner_getairports)
airports = nmr.runjob(j)
@fact length(airports) --> 30
