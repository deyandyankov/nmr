### Determine the number of flights from each airport, include a list of any airports not used.
reload("nmr")
j = nmr.NMR(3, "AComp_Passenger_data.csv", nmr.mapper_numberofflights, nmr.reducer_numberofflights, nmr.combiner_numberofflights)
numberofflights = nmr.runjob(j)
@fact length(length(numberofflights)) --> 28
