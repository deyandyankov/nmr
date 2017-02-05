immutable udf_airport
  id::String
end

immutable udf_flight
  flightid::String
  airport::Nullable{udf_airport}
end
