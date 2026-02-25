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

function suffix(s::Signedness, d::Domain)
    schar = is_unsigned(s) ? 'u' : 's'
    dchar = is_finite(d) ? 'f' : 'e'
    string(schar, dchar)
end

  
