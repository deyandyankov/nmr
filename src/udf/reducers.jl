function reducer_getairports(s)
  s
end

function reducer_numberofflights(s)
  u = unique(s)
  flightsfromairport = Dict{Any, UInt}()
  for k in u
    j = JSON.parse(k)
    fromairport = j["originairport"]
    flightsfromairport[fromairport] = get(flightsfromairport, fromairport, 0) + 1
  end

  json(flightsfromairport)
end
function reducer_listofflights(s)
  s
end
function reducer_numberofpassengers(s)
  u = unique(s)
  r = Dict{String, UInt}()
  for k in u
    j = JSON.parse(k)
    flightid = j["flightid"]
    passengerid = j["passengerid"]
    r[flightid] = get(r, flightid, 0) + 1
  end
  json(r)
end
