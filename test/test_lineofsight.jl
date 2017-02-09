### Calculate the line-of-sight (nautical) miles for each flight and the total travelled by each passenger
reload("nmr")

# this gives us list of flights with [flightid, [srcairport, dstairport]]
j = nmr.NMR(4, "AComp_Passenger_data.csv", nmr.mapper_parserecordacomp, nmr.reducer_lineofsightpassenger, nmr.combiner_parsejson)
listofflights = nmr.runjob(j)

# we need to join the above with airport coordinates to calculate line of sight for each flight
# we must then create a mr job to calculate passengers and their flights with src and dst airport
# .. to calculate total miles travelled by each passenger
