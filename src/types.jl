const MaybeBool = Union{Bool, Nothing}

struct Signedness
   unsigned::Bool
     signed::Bool
end

is_unsigned(x::Signedness) = x.unsigned
is_signed(x::Signedness) = x.signed

function Signedness(; unsigned::MaybeBool=nothing, signed::MaybeBool=nothing)
    if (unsigned == signed) || (isnothing(unsigned) && isnothing(signed))
       error("unsigned ($unsigned) and signed ($signed) cannot both be nothing, or the same truth value.") 
    end
    
    unsigned = isnothing(unsigned) ? !signed : unsigned
    signed = isnothing(signed) ? !unsigned : signed
    Signedness(unsigned, signed)
end

struct Domain
   finite::Bool
   extended::Bool
end

is_finite(x::Domain) = x.finite
is_extended(x::Domain) = x.extended

function Domain(; finite::MaybeBool=nothing, extended::MaybeBool=nothing)
    if (finite == extended) || (isnothing(finite) && isnothing(extended))
       error("finite ($finite) and extended ($extended) cannot both be nothing, or the same truth value.") 
    end

    finite = isnothing(finite) ? !extended : finite
    extended = isnothing(extended) ? !finite : extended
    Domain(finite, extended)
end

function suffix(is_signed::Bool, is_extended::Bool)
    schar = !is_signed ? 'u' : 's'
    dchar = !is_extended ? 'f' : 'e'
    string(schar, dchar)
end

function suffix(s::Signedness, d::Domain)
    schar = is_unsigned(s) ? 'u' : 's'
    dchar = is_finite(d) ? 'f' : 'e'
    string(schar, dchar)
end

struct Format
   K::Int
   P::Int
   σ::Bool
   δ::Bool
end

function Format(K::Int, P::Int, Σ::Signedness, Δ::Domain)
    σ = is_signed(Σ)
    δ = is_extended(Δ)
    if (P < 1)
       error("P ($P) < 1")
   elseif (K < P - σ)
        error("K >= P - σ ($K >= $P - $σ)")
    end
    Format(K, P, σ, δ)
end

function Base.string(x::Format)
    string("Binary", x.K, "p", x.P, suffix(x.σ, x.δ))
end

function Base.show(io::IO, ::MIME"text/plain", x::Format)
    print(io, string(x))
end

BitwidthOf(x::Format) = x.K
PrecisionOf(x::Format) = x.P
TrailingBitsOf(x::Format) = PrecisionOf(x) - 1
SignBitsOf(x::Format) = x.σ + 0
ExponentBitsOf(x::Format) = BitwidthOf(x) - PrecisionOf(x) + is_unsigned(x)
ExponentBiasOf(x::Format) = 2^(ExponentBitsOf(x) - 1) - is_signed(x)


