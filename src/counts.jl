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

nPositiveSubnormalsOf(x::Format) = let P = PrecisionOf(x);
    isone(P) && return 0
    twopowm1(P) - 1
end

nTotalSubnormalsOf(x::Format) = SignMultiplicityOf(x) * nPositiveSubnormalsOf(x)

nNegativeSubnormalsOf(x::Format) = is_signed(x) * nPositiveSubnormalsOf(x)

nSubnormalsOf(x::Format) = twopow(PrecisionOf(x) - is_unsigned(x)) - 1 - is_signed(x)

nPrenormalsOf(x::Format) = nSubnormalsOf(x) + 1
nNonnegativePrenormalsOf(x::Format) = nPositiveSubnormalsOf(x) + 1
nNonpositivePrenormalsOf(x::Format) = nNegativeSubnormalsOf(x) + 1

nNormalsOf(x::Format) = nFinitesOf(x) - nPrenormalsOf(x)
nPositiveNormalsOf(x::Format) = nPositiveFinitesOf(x) - nNonnegativePrenormalsOf(x)
nNegativeNormalsOf(x::Format) = is_signed(x) * nPositiveNormalsOf(x)

#=
Let 𝐸max_finite be the maximum biased exponent field value that is still usable by finite normals
    (i.e., the highest exponent-field value that is not “lost” to NaN/Inf encodings in the low-precision corner cases)
=#

nPosSubnormalsOf(x::Format) = twopowm1(Precision(x)) - 0x01
nSubnormalsOf(x::Format) = SignMultiplicityOf(x) * nPosSubnormalsOf(x)

nPosNormalsOf(x::Format) = twopowm1(Precision(x)) * Emax_finite(x)
nNormalsOf(x::Format) = SignMultiplicityOf(x) * nPosNormalsOf(x)

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





