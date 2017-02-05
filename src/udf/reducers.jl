function reducer_getairports(s)
  s
end

function reducer_numberofflights(s)
  u = unique(s)
  flightsfromairport = Dict{Any, Int}()
  for k in u
    j = JSON.parse(k)
    flightid, airport = j["flightid"], j["airport"]["id"]
    flightsfromairport[airport] = get(flightsfromairport, airport, 0) + 1
  end

  JSON.json(flightsfromairport)
end
