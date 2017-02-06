import Base: ==, convert, promotevaluerule

abstract UDFType{T}
promotevaluerule{T}(x::Type{UDFType{T}}, y::Type{T}) = T
convert{T}(::Type{T}, x::UDFType{T}) = convert(T, x.value)
=={T}(x::UDFType{T}, y::UDFType{T}) = x.value == y.value
=={T}(x::T, y::UDFType{T}) = x == convert(T, y.value)
=={T}(x::UDFType{T}, y::T) = convert(T, x.value) == y
JSON.lower(x::UDFType) = x.value

immutable UDFAirportName{T<:AbstractString} <: UDFType
  value::T
end
function UDFAirportName{T<:AbstractString}(value::T)
  length(value) < 3 && throw(UDFException("Airport Name must be longer than 3 characters: $value"))
  length(value) > 20 && throw(UDFException("Airport Name must be shorter than 20 symbols: $value"))
  UDFAirportName{T}(value)
end

immutable UDFAirportCode{T<:AbstractString} <: UDFType
  value::T
end
function UDFAirportCode{T<:AbstractString}(value::T)
  m = match(r"^[A-Z]{3}$", value)
  is(typeof(m), Void) && throw(UDFException("Airport id must be comprised of three capital letters. Trying to initialise with $value instead."))
  UDFAirportCode{T}(value)
end

immutable UDFFlightId{T<:AbstractString} <: UDFType
  value::T
end
function UDFFlightId{T<:AbstractString}(value::T)
  m = match(r"^[A-Z0-9]{8}$", value)
  is(typeof(m), Void) && throw(UDFException("Invalid flight id: $value"))
  UDFFlightId{T}(value)
end

immutable UDFPassengerId{T<:AbstractString} <: UDFType
  value::T
end
function UDFPassengerId{T<:AbstractString}(value::T)
  m = match(r"^[A-Z0-9]{10}$", value)
  is(typeof(m), Void) && throw(UDFException("Invalid passenger id: $value"))
  UDFPassengerId{T}(value)
end
