import Base: ==, convert

abstract UDFType
=={T<:UDFType}(x::T, y::T) = x.value == y.value
JSON.lower(x::UDFType) = x.value

abstract UDFNPType <: UDFType

abstract UDFPtype{T} <: UDFType
promote_rule{T}(x::Type{UDFPtype{T}}, y::Type{T}) = T
convert{T}(::Type{T}, x::UDFPtype{T}) = convert(T, x.value)
# =={T}(x::T, y::UDFPtype{T}) = x == convert(T, y.value)
# =={T}(x::UDFPtype{T}, y::T) = convert(T, x.value) == y

immutable UDFAirportName{T<:AbstractString} <: UDFPtype
  value::T
end
function UDFAirportName{T<:AbstractString}(value::T)
  length(value) < 3 && throw(UDFException("Airport Name must be longer than 3 characters: $value"))
  length(value) > 20 && throw(UDFException("Airport Name must be shorter than 20 symbols: $value"))
  UDFAirportName{T}(value)
end

immutable UDFAirportCode{T<:AbstractString} <: UDFPtype
  value::T
end
function UDFAirportCode{T<:AbstractString}(value::T)
  m = match(r"^[A-Z]{3}$", value)
  is(typeof(m), Void) && throw(UDFException("Airport id must be comprised of three capital letters. Trying to initialise with $value instead."))
  UDFAirportCode{T}(value)
end

immutable UDFFlightId{T<:AbstractString} <: UDFPtype
  value::T
end
function UDFFlightId{T<:AbstractString}(value::T)
  m = match(r"^[A-Z0-9]{8}$", value)
  is(typeof(m), Void) && throw(UDFException("Invalid flight id: $value"))
  UDFFlightId{T}(value)
end

immutable UDFPassengerId{T<:AbstractString} <: UDFPtype
  value::T
end
function UDFPassengerId{T<:AbstractString}(value::T)
  m = match(r"^[A-Z0-9]{10}$", value)
  is(typeof(m), Void) && throw(UDFException("Invalid passenger id: $value"))
  UDFPassengerId{T}(value)
end

immutable UDFDepartureTime <: UDFNPType
  value::DateTime
end
function UDFDepartureTime{T<:AbstractString}(value::T)
  m = match(r"^[0-9]*$", value)
  is(typeof(m), Void) && throw(UDFException("Invalid DepartureTime: $value"))
  UDFDepartureTime(parse(value))
end
function UDFDepartureTime{T<:Real}(value::T)
  UDFDepartureTime(Dates.unix2datetime(value))
end

immutable UDFTotalFlightTime <: UDFNPType
  value::Int16
end
convert{T<:Real}(::Type{T}, x::UDFTotalFlightTime) = convert(T, x.value)

function UDFTotalFlightTime{T<:Real}(value::T)
  UDFTotalFlightTime(convert(Int16, value))
end
function UDFTotalFlightTime{T<:AbstractString}(value::T)
  x = parse(Int16, value)
  x < 0 && throw(UDFException("total flight time must be a positive integer"))
  x > 1200 && throw(UDFException("invalid flight time $x - flights cannot go longer than 20 hours"))
  UDFTotalFlightTime(x)
end
