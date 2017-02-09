reducer_noop(s) = s
function reducer_numberofflights(s)
  u = unique(s)
  r = Dict{String, UInt}()
  for k in u
    j = JSON.parse(k)
    fromairport = j["originairport"]
    r[fromairport] = get(r, fromairport, 0) + 1
  end
  r
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
  r
end
function reducer_lineofsightpassenger(s)
  u = unique(s)
  r = Dict{String, Tuple{String, String}}()
  for k in u
    j = JSON.parse(k)
    key = j["flightid"]
    value = (j["originairport"], j["dstairport"])
    r[key] = value
  end

  [(k, v) for (k, v) in r]
end
