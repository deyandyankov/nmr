type UDFRAcomp
  passengerid::String
  flightid::String
  originairport::String
  dstairport::String
  departuretime::DateTime
  arrivaltime::DateTime
  totalflighttime::Int16
end

function UDFAirportName{T<:AbstractString}(value::T)
  length(value) < 3 && throw(UDFException("Airport Name must be longer than 3 characters: $value"))
  length(value) > 20 && throw(UDFException("Airport Name must be shorter than 20 symbols: $value"))
  value
end

function UDFAirportCode{T<:AbstractString}(value::T)
  m = match(r"^[A-Z]{3}$", value)
  is(typeof(m), Void) && throw(UDFException("Airport id must be comprised of three capital letters. Trying to initialise with $value instead."))
  value
end

function UDFFlightId{T<:AbstractString}(value::T)
  m = match(r"^[A-Z0-9]{8}$", value)
  is(typeof(m), Void) && throw(UDFException("Invalid flight id: $value"))
  value
end

function UDFPassengerId{T<:AbstractString}(value::T)
  m = match(r"^[A-Z0-9]{10}$", value)
  is(typeof(m), Void) && throw(UDFException("Invalid passenger id: $value"))
  value
end

UDFDepartureTime{T<:Real}(value::T) = Dates.unix2datetime(value)
function UDFDepartureTime{T<:AbstractString}(value::T)
  m = match(r"^[0-9]*$", value)
  is(typeof(m), Void) && throw(UDFException("Invalid DepartureTime: $value"))
  UDFDepartureTime(parse(value))
end

function UDFTotalFlightTime{T<:AbstractString}(value::T)
  x = parse(Int16, value)
  x < 0 && throw(UDFException("total flight time must be a positive integer"))
  x > 1200 && throw(UDFException("invalid flight time $x - flights cannot go longer than 20 hours"))
  x
end
