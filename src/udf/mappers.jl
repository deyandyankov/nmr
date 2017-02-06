function mapper_parserecordacomp(x::AbstractString)
  line = chomp(x)
  separator = ","
  isempty(line) && throw(MapperException("line is empty"))
  s = split(line, separator)
  length(s) < 6 && throw(MapperException("malformed line has less than six elements when split by ,"))
  r = Dict{Symbol, Any}()
  r[:flightid] = get(UDFFlightId(s[2]))
  r[:fromairport] = get(UDFAirportCode(s[3]))
  r
end

function mapper_numberofflights(x::AbstractString)
  r = mapper_parserecordacomp(x)
  JSON.json(r)
end
