### Calculate the number of passengers on each flight
reload("nmr")
j = nmr.NMR(3, "AComp_Passenger_data.csv", nmr.mapper_numberofpassengers, nmr.reducer_numberofpassengers, nmr.combiner_numberofpassengers)
numberofpassengers = nmr.runjob(j)
