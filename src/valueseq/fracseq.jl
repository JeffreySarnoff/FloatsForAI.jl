function fractionals(x::AIFloat)
    n_fractional_values = x.n_fracs			   # you could
    cycles = x.n_values ÷ n_fractional_values

    repeat( (0:n_fractional_values-1) ./ n_fractional_values;
            outer=cycles )
end
