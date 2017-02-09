### Calculate the number of passengers on each flight
reload("nmr")
j = nmr.NMR(3, "AComp_Passenger_data.csv", nmr.mapper_parserecordacomp, nmr.reducer_numberofpassengers, nmr.combiner_parsejson)
numberofpassengers = nmr.runjob(j)
@test JSON.parse(numberofflights[1])["first"] == "AMS"
