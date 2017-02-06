import Base: get, show

abstract UDFType
get{T<:UDFType}(x::T) = x._
show{T<:UDFType}(io::IO, x::T) = print(io, x._)

abstract UDFTypeString <: UDFType

immutable UDFAirportName{T<:AbstractString} <: UDFTypeString
  _::T
end
function UDFAirportName{T<:AbstractString}(_::T)
  length(_) < 3 && throw(UDFException("Airport Name must be longer than 3 characters: $_"))
  length(_) > 20 && throw(UDFException("Airport Name must be shorter than 20 symbols: $_"))
  UDFAirportName{T}(_)
end

immutable UDFAirportCode{T<:AbstractString} <: UDFTypeString
  _::T
end
function UDFAirportCode{T<:AbstractString}(_::T)
  m = match(r"^[A-Z]{3}$", _)
  is(typeof(m), Void) && throw(UDFException("Airport id must be comprised of three capital letters. Trying to initialise with $_ instead."))
  UDFAirportCode{T}(_)
end

immutable UDFFlightId{T<:AbstractString} <: UDFTypeString
  _::T
end
