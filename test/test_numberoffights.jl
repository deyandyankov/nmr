### Determine the number of flights from each airport, include a list of any airports not used.
reload("nmr")
j = nmr.NMR(1, "AComp_Passenger_data.csv", nmr.mapper_parserecordacomp, nmr.reducer_numberofflights, nmr.combiner_parsejson)
numberofflights = nmr.runjob(j)
# todo: fix weird output format
@test JSON.parse(numberofflights[1])["first"] == "AMS"
