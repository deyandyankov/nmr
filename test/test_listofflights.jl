### Create a list of flights based on the Flight id, this output should include the passenger Id,
# relevant IATA/FAA codes, the departure time, the arrival time
# (times to be converted toHH:MM:SS format), and the flight times.
reload("nmr")
j = nmr.NMR(2, "AComp_Passenger_data.csv", nmr.mapper_parserecordacomp, nmr.reducer_noop, nmr.combiner_parsejson)
listofflights = nmr.runjob(j)
@test JSON.parse(JSON.parse(listofflights[1]))["originairport"] == "DEN"
