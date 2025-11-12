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
    # build the unsigned-like ladder first
    stride = x.n_values ÷ 2^x.exp_bits
    # poz is positive or zero
    poz = non_negative(x, stride)
    
    # signed layouts only use the first half as the positive side
    nonneg = poz[1:end>>>1]

    if Δ === :extended
        # highest positive gets +Inf
        nonneg[end] = T(Inf)
    end

    # negatives are the positives except the first (to avoid -0)
    neg = -one(T) .* nonneg[2:end]

    # signed layout: [+..., NaN, -...]
    return vcat(nonneg, T(NaN), neg)
end


#
# SIGNED (finite or extended)
#
function valueseq(x::AIFloat{T, :signed, Δ}) where {T, Δ}
    # build the unsigned-like ladder first
    u = AIFloat(x.bitwidth, x.precision+1, :unsigned, Δ; T)
    stride = u.n_values ÷ 2^u.exp_bits
    # poz is positive or zero, does not index NaN
    poz = non_negative(u, stride)[1:2:end]
    
    if Δ === :extended
        # highest positive gets +Inf
        poz[end] = T(Inf)
    end

    # negatives are the positives except the first (to avoid -0)
    neg = -one(T) .* poz[2:end]

    # signed layout: [+..., NaN, -...]
    return vcat(poz, T(NaN), neg)
end

function non_negative(x::AIFloat, stride)
    exponent_values   = exponents(x, stride)
    fractional_values = fractionals(x)
    implicit_bits     = implicits(x)

    significand_values = fractional_values .+ implicit_bits
    exponent_values .* significand_values
end

