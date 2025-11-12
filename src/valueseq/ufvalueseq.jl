function valueseq(x::AIFloat{T, :unsigned, :finite}) where {T}    

    stride = x.n_values ÷ 2^x.exp_bits                  # spans’ width

    exponent_values   = exponents(x, stride)
    fractional_values = fractionals(x) 
    implicit_bits     = implicits(x)                    # 0, 1 if normal

    significand_values = fractional_values .+ implicit_bits
    values = exponent_values .* significand_values
    values[end] = T(NaN)

    values                                              # return(values)
end
