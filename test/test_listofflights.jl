### Create a list of flights based on the Flight id, this output should include the passenger Id,
# relevant IATA/FAA codes, the departure time, the arrival time
# (times to be converted toHH:MM:SS format), and the flight times.
reload("nmr")
j = nmr.NMR(2, "AComp_Passenger_data.csv", nmr.mapper_listofflights, nmr.reducer_listofflights, nmr.combiner_listofflights)
listofflights = nmr.runjob(j)
