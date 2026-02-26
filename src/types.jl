# ── Signedness trait types ──
abstract type SignednessKind end
struct SIGNED   <: SignednessKind end
struct UNSIGNED <: SignednessKind end

struct Domain
   finite::Bool
   extended::Bool
end

is_finite(x::Domain) = x.finite
is_extended(x::Domain) = x.extended

Base.convert(Int, x::Domain) = 0 + x.extended
Base.Int(x::Domain) = Base.convert(Int, x)

const Finite   = Domain(true, false)
const Extended = Domain(false, true)

function Domain(; finite::MaybeBool=nothing, extended::MaybeBool=nothing)
    if (finite == extended) || (isnothing(finite) && isnothing(extended))
       error("finite ($finite) and extended ($extended) cannot both be nothing, or the same truth value.")
    end

    finite = isnothing(finite) ? !extended : finite
    extended = isnothing(extended) ? !finite : extended
    Domain(finite, extended)
end

# ── Parametric Format type ──
struct Format{S<:SignednessKind}
   K::Int
   P::Int
   δ::Bool
end

const SignedFormat   = Format{SIGNED}
const UnsignedFormat = Format{UNSIGNED}
const SFormat = SignedFormat
const UFormat = UnsignedFormat

# ── Signedness dispatch ──
is_signed(::Format{SIGNED})     = true
is_signed(::Format{UNSIGNED})   = false
is_unsigned(::Format{SIGNED})   = false
is_unsigned(::Format{UNSIGNED}) = true

# ── Domain accessors ──
is_finite(x::Format)   = !x.δ
is_extended(x::Format) = x.δ

# ── Constructors ──
function Format{S}(K::Int, P::Int, Δ::Domain) where {S<:SignednessKind}
    σ = S === SIGNED ? 1 : 0
    if P < 1
       error("P ($P) < 1")
    elseif K < P - σ
        error("K ($K) < P - σ ($P - $σ)")
    end
    Format{S}(K, P, is_extended(Δ))
end

# ── Display ──
function suffix(x::Format)
    schar = is_unsigned(x) ? 'u' : 's'
    dchar = is_finite(x) ? 'f' : 'e'
    string(schar, dchar)
end

function Base.string(x::Format)
    string("Binary", x.K, "p", x.P, suffix(x))
end

function Base.show(io::IO, ::MIME"text/plain", x::Format)
    print(io, string(x))
end

# ── Accessors ──
BitwidthOf(x::Format)  = x.K
PrecisionOf(x::Format) = x.P
TrailingBitsOf(x::Format) = PrecisionOf(x) - 1
SignBitsOf(::Format{SIGNED})   = 1
SignBitsOf(::Format{UNSIGNED}) = 0
ExponentBitsOf(x::Format) = WuOf(x) + is_unsigned(x)

ExponentFieldBitsOf(x::Format) = BitwidthOf(x) - PrecisionOf(x) + (1 - is_signed(x))
SignMultiplicityOf(x::Format) = 0x01 + is_signed(x)

ExponentBiasOf(x::Format) = pow2WuOf(x) - is_signed(x)

WuOf(x::Format) = BitwidthOf(x) - PrecisionOf(x)
WuOfm1(x::Format) = BitwidthOf(x) - PrecisionOf(x) - 1

function pow2WuOf(x::Format)
    twopow(WuOf(x))
end

function pow2WuOfm1(x::Format)
    twopowm1(WuOf(x))
end

ExponentMinOf(x::Format) = 1 - ExponentBiasOf(x)

ExponentMaxOf(x::SignedFormat) = pow2WuOfm1(x) - 1 - (PrecisionOf(x) <= 2)
function ExponentMaxOf(x::UnsignedFormat)
   if PrecisionOf(x) > 2
      return pow2WuOf(x) - 1
   end
   P = PrecisionOf(x)
   pow2WuOf(x) - 2 - is_extended(x) * ( 2 - P )
end
