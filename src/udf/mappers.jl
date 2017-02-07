function mapper_parserecordacomp(x::AbstractString)
  line = chomp(x)
  separator = ","
  isempty(line) && throw(MapperException("line is empty"))
  s = split(line, separator)
  length(s) < 6 && throw(MapperException("malformed line has less than six elements when split by ,"))
  r = Dict(
    Symbol("passengerid") => UDFPassengerId(s[1]),
    Symbol("flightid") => UDFFlightId(s[2]),
    Symbol("originairport") => UDFAirportCode(s[3]),
    Symbol("dstairport") => UDFAirportCode(s[4]),
    Symbol("departuretime") => UDFDepartureTime(s[5]),
    Symbol("totalflighttime") => UDFTotalFlightTime(s[6])
  )
  # todo: fix the below, not pretty
  r[Symbol("arrivaltime")] = r[:departuretime].value + Dates.Minute(convert(Integer, r[:totalflighttime]))
  r
end

function mapper_numberofflights(x::AbstractString)
  r = mapper_parserecordacomp(x)
  JSON.json(r)
end

function mapper_listofflights(x::AbstractString)
  r = mapper_parserecordacomp(x)
  JSON.json(r)
end
function mapper_numberofpassengers(x::AbstractString)
  r = mapper_parserecordacomp(x)
  t = Dict{Symbol, Any}(
    Symbol("flightid") => r[:flightid],
    Symbol("passengerid") => r[:passengerid]
  )
  JSON.json(t)
end
