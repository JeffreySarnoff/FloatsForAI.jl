# valueseq.jl

# common helpers are in value_support.jl:
#   exponents(x, stride)
#   fractionals(x)
#   implicits(x)

#
# UNSIGNED (finite or extended)
#
function valueseq(x::AIFloat{T, :unsigned, Δ}) where {T, Δ}
    # span width: how many fractionals we repeat per exponent
    stride = x.n_values ÷ 2^x.exp_bits
    # poz is positive or zero
    poz = non_negative(x, stride)

    poz[end] = T(NaN)
    if Δ === :extended
        # next-to-last is +Inf
        poz[end-1] = T(Inf)
    end

    return poz  
end

#
# SIGNED (finite or extended)
#
function valueseq(x::AIFloat{T, :signed, Δ}) where {T, Δ}
    # signed from unsigned
    u = AIFloat(x.bitwidth, x.precision+1, :unsigned, Δ; T)
    poz = valueseq(u)[1:2:end]

    if Δ === :extended
        poz[end] = T(Inf)
    end

    neg = -one(T) .* poz[2:end]   # sign-symmetric nonzero numerics
    vcat(poz, T(NaN), neg)        # [+..++, NaN, -..--]
end 
 

function non_negative(x::AIFloat, stride)
    exponent_values   = exponents(x, stride)
    fractional_values = fractionals(x)
    implicit_bits     = implicits(x)

    significand_values = fractional_values .+ implicit_bits
    exponent_values .* significand_values
end

