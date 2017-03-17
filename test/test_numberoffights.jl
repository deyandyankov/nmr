### Determine the number of flights from each airport, include a list of any airports not used.
reload("nmr")

nmr.runjob(nmr.NMR(1, ["AComp_Passenger_data.csv"], nmr.mapper_parserecordacomp, "acomp.csv"))
nmr.runjob(nmr.NMR(1, ["acomp.csv"], nmr.reducer_numberofflights, "acomp_flights_reduced.csv"))
c = nmr.runcombiner("acomp_flights_reduced.csv", nmr.combiner_parsejson)

@test typeof(c) == Vector{String}
@test length(c) == 17
@test JSON.parse(c[1])[1] == "AMS"
@test JSON.parse(c[1])[2] == 13
