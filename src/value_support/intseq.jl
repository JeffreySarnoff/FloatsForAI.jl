function implicits(x::AIFloat)
    T = valuetype(x)
    implicit_bits = ones(T, x.n_values)
    implicit_bits[1:x.n_fracs] .= zero(T)
    implicit_bits
end
