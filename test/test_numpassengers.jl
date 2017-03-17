### Calculate the number of passengers on each flight
reload("nmr")

nmr.runjob(nmr.NMR(3, ["AComp_Passenger_data.csv"], nmr.mapper_parserecordacomp, "acomp.csv"))
nmr.runjob(nmr.NMR(3, ["acomp.csv"], nmr.reducer_numberofpassengers, "acomp_reduced.json"))
c = nmr.runcombiner("acomp_reduced.json", nmr.combiner_parsejson)

@test typeof(c) == Vector{String}
@test length(c) == 17
