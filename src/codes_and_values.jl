# the encoding sequence for any format

function codes(x::AIFloat)
    n = x.n_values
    T = x.bitwidth <= 8  ? UInt8  :
        x.bitwidth <= 16 ? UInt16 :
        x.bitwidth <= 32 ? UInt32 :
                           UInt64
    return map(T, collect(0:n-1))
end

# the value sequence for any Unsigned formats
function values(x::AIFloat{T, :unsigned, Δ}) where {T, Δ}
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

# the value sequence for any Signed formats
function values(x::AIFloat{T, :signed, Δ}) where {T, Δ}
    # signed from unsigned
    u = AIFloat(x.bitwidth, x.precision+1, :unsigned, Δ; T)
    poz = values(u)[1:2:end]

    if Δ === :extended
        poz[end] = T(Inf)
    end

    neg = -one(T) .* poz[2:end]   # sign-symmetric nonzero numerics
    vcat(poz, T(NaN), neg)        # [+..++, NaN, -..--]
end
