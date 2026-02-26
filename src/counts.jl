nNaNsOf(x::Format) = 1
nZerosOf(x::Format) = 1
nInfsOf(x::Format) = is_finite(x) ? 0 : (1 + is_signed(x))

nValuesOf(x::Format) = let K = BitwidthOf(x);
    twopow(K)
end
  
nNumericValuesOf(x::Format) = nValuesOf(x) - 1
nNonFinitesOf(x::Format) = nNaNsOf(x) + nInfsOf(x)
nFinitesOf(x::Format) = nValuesOf(x) - nNonFinitesOf(x)
nNonzeroFinitesOf(x::Format) = nFinitesOf(x) - nZerosOf(x)

nPositiveFinitesOf(x::Format) = nNonzeroFinitesOf(x) >> is_signed(x)
nNegativeFinitesOf(x::Format) = is_signed(x) * nPositiveFinitesOf(x)
nNonnegativeFinitesOf(x::Format) = nPositiveFinitesOf(x) + 1

nPrenormalsOf(x::Format) = nSubnormalsOf(x) + 1
nNonnegativePrenormalsOf(x::Format) = nPositiveSubnormalsOf(x) + 1
nNonpositivePrenormalsOf(x::Format) = nNegativeSubnormalsOf(x) + 1

#=
Let 𝐸max_finite be the maximum biased exponent field value that is still usable by finite normals
    (i.e., the highest exponent-field value that is not “lost” to NaN/Inf encodings in the low-precision corner cases)
=#

nPosititveSubnormalsOf(x::Format) = twopowm1(Precision(x)) - 0x01
nNegativeSubnormalsOf(x::Format) = is_signed(x) * nPositiveSubnormalsOf(x)
nSubnormalsOf(x::Format) = SignMultiplicityOf(x) * nPositiveSubnormalsOf(x)

nPositiveNormalsOf(x::Format) = twopowm1(Precision(x)) * Emax_finite(x)
nNegativeNormalsOf(x::Format) = is_signed(x) * nPositiveNormalsOf(x)
nNormalsOf(x::Format) = SignMultiplicityOf(x) * nPositiveNormalsOf(x)

function Emax_finite(x::Format)
    P = Precision(x)
    emaxfinite = twopow_expbits(x) - 0x01
    if is_signed(x)
        emaxfinite -= isone(P)
    else
        emaxfinite -= (P <= 2)
    end
    emaxfinite
end

twopow_expbits(x::Format) = twopow(ExponentFieldBitsOf(x))

#=
Emax_finite_uf(x::Format) = twopow_expbits(x) - 0x01 - isone(Precision(x))
Emax_finite_ue(x::Format) = twopow_expbits(x) - 0x01 - (Precision(x) == 2) - (Precision(x) == 1)
Emax_finite_sf(x::Format) = twopow_expbits(x) - 0x01
Emax_finite_se(x::Format) = twopow_expbits(x) - 0x01 - (Precision(x) == 1)
=#





