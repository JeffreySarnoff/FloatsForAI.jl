function exponents(x::AIFloat, stride::Int)

    span_indices = collect(0:(2^x.exp_bits - 1))
    # subnormals share an exponent with the first normal
    span_indices[1] = span_indices[2] * (x.precision > 1)

    # respect the spans
    repeat(2.0 .^ (span_indices .- x.exp_bias), inner=stride)
end
