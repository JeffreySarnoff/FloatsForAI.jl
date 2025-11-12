function valueseq(x::AIFloat{T, :signed, :finite}) where {T}    

    stride = x.n_values ÷ 2^x.exp_bits                  # spans’ width

    exponent_values   = exponents(x, stride)
    fractional_values = fractionals(x) 
    implicit_bits     = implicits(x)                    # 0, 1 if normal

    significand_values = fractional_values .+ implicit_bits
    values = (exponent_values .* significand_values)[1:end>>1]
    negvalues = -1 .* values[2:end]

    values = vcat( values, T(NaN), negvalues) 
    values                                              # return(values)
end
