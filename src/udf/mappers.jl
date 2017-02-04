function mapper_example(x)
  return chomp(x) * "!!!\n"
end

function mapper_getairports(x)
  ret = Nullable{typeof(x)}()
  s = split(chomp(x), ",")
  airport_name, airport_key, lat, lon = s[2], s[1], parse(s[3]), parse(s[4])
  airport = udf_airport(airport_name, airport_key, lat, lon)
  JSON.json(airport)
end
