### Create a list of flights based on the Flight id, this output should include the passenger Id,
# relevant IATA/FAA codes, the departure time, the arrival time
# (times to be converted toHH:MM:SS format), and the flight times.
reload("nmr")

nmr.runjob(nmr.NMR(3, ["AComp_Passenger_data.csv"], nmr.mapper_parserecordacomp, "acompdata.json"))
c = nmr.runcombiner("acompdata.json", nmr.combiner_parsejson)

@test typeof(c) == Vector{String}
@test length(c) == 264
@test JSON.parse(c[1])["totalflighttime"] == 1049
