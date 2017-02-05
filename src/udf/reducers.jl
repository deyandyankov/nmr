function reducer_getairports(s)
  s
end

function reducer_numberofflights(s)
  u = unique(s)
  flightsfromairport = Dict{String, Int}()
  for k in u
    j = JSON.parse(k)
    flightid, airportcode = j["flightid"], j["airportcode"]
    flightsfromairport[airportcode] = get(flightsfromairport, airportcode, 0) + 1
  end

  JSON.json(flightsfromairport)
end
