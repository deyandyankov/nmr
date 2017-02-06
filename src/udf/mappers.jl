function mapper_parserecordacomp(x::AbstractString)
  line = chomp(x)
  separator = ","
  isempty(line) && throw(MapperException("line is empty"))
  s = split(line, separator)
  length(s) < 6 && throw(MapperException("malformed line has less than six elements when split by ,"))
  Dict(
    Symbol("flightid") => UDFFlightId(s[2]),
    Symbol("originairport") => UDFAirportCode(s[3]),
    Symbol("dstairport") => UDFAirportCode(s[4])
  )
end

function mapper_numberofflights(x::AbstractString)
  r = mapper_parserecordacomp(x)
  JSON.json(r)
end
