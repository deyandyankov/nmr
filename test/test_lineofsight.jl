### Calculate the line-of-sight (nautical) miles for each flight and the total travelled by each passenger
reload("nmr")

# this parses records in AComp_Passenger_data.cs into JSON, handling errors
nmr.runjob(nmr.NMR(4, ["AComp_Passenger_data.csv"], nmr.mapper_parserecordacomp, "acomplineofsight.json"))

# this gives us list of flights with [flightid, [srcairport, dstairport]]
nmr.runjob(nmr.NMR(4, ["acomplineofsight.json"], nmr.reducer_lineofsightpassenger, "lineofsightpassenger.json"))

# combine results
c = nmr.runcombiner("lineofsightpassenger.json", nmr.combiner_parsejson)

# sanity checks
@test typeof(c) == Vector{String}
@test length(c) == 65

# we need to join the above with airport coordinates to calculate line of sight for each flight
# we must then create a mr job to calculate passengers and their flights with src and dst airport
# .. to calculate total miles travelled by each passenger

# join the two output files
nmr.runjob(nmr.NMR(4, ["acomplineofsight.json", "lineofsightpassenger.json"], nmr.joiner_lineofsight, "joinedlineofsight.json"))
