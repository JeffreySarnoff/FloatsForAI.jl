function codes(x::AIFloat)
    n = x.n_values
    T = x.bitwidth <= 8  ? UInt8  :
        x.bitwidth <= 16 ? UInt16 :
        x.bitwidth <= 32 ? UInt32 :
                           UInt64
    return map(T, collect(0:n-1))
end
