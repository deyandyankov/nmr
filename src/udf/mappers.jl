function mapper_getairports(x::AbstractString)
  line = chomp(x)
  separator = ","

  isempty(line) && throw(MapperException("line is empty"))
  s = split(line, separator)
  length(s) < 4 && throw("malformed line has less than four elements")
  airportid = s[2]
  airport = udf_airport(airportid)
  airport.id
end

function mapper_numberofflights(x::AbstractString)
  line = chomp(x)
  separator = ","
  isempty(line) && throw(MapperException("line is empty"))
  s = split(line, separator)
  length(s) < 6 && throw(MapperException("malformed line has less than six elements when split by ,"))
  flightid, originairport = s[2], s[3]
  (isempty(flightid) || isempty(originairport)) && throw(MapperException("malformed line (empty flight/origin)"))

  airport = udf_airport(originairport)
  flight = udf_flight(flightid, udf_airport(originairport))
  JSON.json(flight)
end
