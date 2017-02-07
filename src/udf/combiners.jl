function combiner_getairports(input)
    map(chomp, input)
end
function combiner_numberofflights(input)
  JSON.parse(input[1])
end
function combiner_listofflights(input)
  [JSON.parse(line) for line in input]
end
function combiner_numberofpassengers(input)
  [JSON.parse(line) for line in input]
end
