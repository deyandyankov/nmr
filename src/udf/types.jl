immutable udf_airport
  id::String

  function udf_airport(id)
    m = match(r"^[A-Z]{3}$", id)
    is(typeof(m), Void) && throw(UDFException("Airport id must be comprised of three capital letters. Trying to initialise with $id instead."))
    new(id)
  end
end

immutable udf_flight
  flightid::String
  airport::Nullable{udf_airport}
end
