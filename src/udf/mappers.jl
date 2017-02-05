function mapper_getairports(x::AbstractString)
  default_return = Nullable{typeof(x)}()
  line = chomp(x)
  separator = ","

  if line == ""
    info("mapper: skipping empty line...")
    return default_return
  end

  s = split(line, separator)
  if length(s) < 4
    info("mapper: skipping malformed line: $(line)")
    return default_return
  end

  airportcode = s[1]
  airport = udf_airport(airportcode)
  Nullable(airport.airportcode)
end

function mapper_numberofflights(x::AbstractString)
  default_return = Nullable{typeof(x)}()
  line = chomp(x)
  separator = ","

  if line == ""
    info("mapper: skipping empty line...")
    return default_return
  end

  s = split(line, separator)
  if length(s) < 6
    info("mapper: skipping malformed line: $(line)")
    return default_return
  end

  flightid, originairport = s[2], s[3]
  if flightid == "" || originairport == ""
    info("mapper: skipping malformed line: $(line)")
    return default_return
  end

  flight = udf_flight(flightid, originairport)
  Nullable(JSON.json(flight))
end
