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

    exponent_values   = exponents(x, stride)
    fractional_values = fractionals(x)
    implicit_bits     = implicits(x)

    significand_values = fractional_values .+ implicit_bits
    values = exponent_values .* significand_values

    values[end] = T(NaN)
    if Δ === :extended
        # next-to-last is +Inf
        values[end-1] = T(Inf)
    end

    return values
end

#
# SIGNED (finite or extended)
#
function valueseq(x::AIFloat{T, :signed, Δ}) where {T, Δ}
    # build the unsigned-like ladder first
    stride = x.n_values ÷ 2^x.exp_bits

    exponent_values   = exponents(x, stride)
    fractional_values = fractionals(x)
    implicit_bits     = implicits(x)

    significand_values = fractional_values .+ implicit_bits
    allpos = exponent_values .* significand_values

    # signed layouts only use the first half as the positive side
    # (your struct makes n_values the total encodings)
    pos = allpos[1:end>>>1]

    if Δ === :extended
        # highest positive gets +Inf
        pos[end] = T(Inf)
    end

    # negatives are the positives except the first (to avoid -0)
    neg = -one(T) .* pos[2:end]

    # signed layout: [+..., NaN, -...]
    return vcat(pos, T(NaN), neg)
end
