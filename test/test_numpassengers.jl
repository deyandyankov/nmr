### Calculate the number of passengers on each flight
reload("nmr")

nmr.runjob(nmr.NMR(3, ["AComp_Passenger_data.csv"], nmr.mapper_parserecordacomp, "acomp.csv"))
nmr.runjob(nmr.NMR(3, ["acomp.csv"], nmr.reducer_numberofpassengers, "acomp_reduced.csv"))
c = nmr.runcombiner("acomp_reduced.csv", nmr.combiner_parsejson)

@test typeof(c) == Vector{String}
@test length(c) == 65
# todo: check numbers, they seem fishy
# println(c)
