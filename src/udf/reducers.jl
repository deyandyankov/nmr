function reducer_getairports(s)
  s
end

function reducer_numberofflights(s)
  u = unique(s)
  flightsfromairport = Dict{Any, Int}()
  for k in u
    j = JSON.parse(k)
    flightid = j["flightid"]
    fromairport = j["fromairport"]
    flightsfromairport[fromairport] = get(flightsfromairport, fromairport, 0) + 1
  end

  JSON.json(flightsfromairport)
end
