function non_negative(x::AIFloat, stride)
    exponent_values   = exponents(x, stride)
    fractional_values = fractionals(x)
    implicit_bits     = implicits(x)

    significand_values = fractional_values .+ implicit_bits
    exponent_values .* significand_values
end

function exponents(x::AIFloat, stride::Int)

    span_indices = collect(0:(2^x.exp_bits - 1))
    # subnormals share an exponent with the first normal
    span_indices[1] = span_indices[2] * (x.precision > 1)

    # respect the spans
    repeat(2.0 .^ (span_indices .- x.exp_bias), inner=stride)
end

function fractionals(x::AIFloat)
    n_fractional_values = x.n_fracs			   # you could
    cycles = x.n_values ÷ n_fractional_values

    repeat( (0:n_fractional_values-1) ./ n_fractional_values;
            outer=cycles )
end

function implicits(x::AIFloat)
    T = valuetype(x)
    implicit_bits = ones(T, x.n_values)
    implicit_bits[1:x.n_fracs] .= zero(T)
    implicit_bits
end


