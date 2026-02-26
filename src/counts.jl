nNaNsOf(x::Format) = 1
nZerosOf(x::Format) = 1

nInfsOf(x::SignedFormat) = is_finite(x) ? 0 : 2
nInfsOf(x::UnsignedFormat) = is_finite(x) ? 0 : 1

nValuesOf(x::Format) =
    let K = BitwidthOf(x)
        twopow(K)
    end

nNumericValuesOf(x::Format) = nValuesOf(x) - 1
nNonFinitesOf(x::Format) = nNaNsOf(x) + nInfsOf(x)
nFinitesOf(x::Format) = nValuesOf(x) - nNonFinitesOf(x)
nNonzeroFinitesOf(x::Format) = nFinitesOf(x) - nZerosOf(x)

nPositiveFinitesOf(x::SignedFormat) = nNonzeroFinitesOf(x) >> 1
nPositiveFinitesOf(x::UnsignedFormat) = nNonzeroFinitesOf(x)

nNegativeFinitesOf(::UnsignedFormat) = 0
nNegativeFinitesOf(x::SignedFormat) = nPositiveFinitesOf(x)

nNonnegativeFinitesOf(x::Format) = nPositiveFinitesOf(x) + 1

nPrenormalsOf(x::Format) = nSubnormalsOf(x) + 1
nNonnegativePrenormalsOf(x::Format) = nPositiveSubnormalsOf(x) + 1
nNonpositivePrenormalsOf(x::Format) = nNegativeSubnormalsOf(x) + 1

#=
Let 𝐸max_finite be the maximum biased exponent field value that is still usable by finite normals
    (i.e., the highest exponent-field value that is not "lost" to NaN/Inf encodings in the low-precision corner cases)
=#

nPositiveSubnormalsOf(x::Format) = twopowm1(PrecisionOf(x)) - 0x01

nNegativeSubnormalsOf(::UnsignedFormat) = 0
nNegativeSubnormalsOf(x::SignedFormat) = nPositiveSubnormalsOf(x)

nSubnormalsOf(x::Format) = SignMultiplicityOf(x) * nPositiveSubnormalsOf(x)

nPositiveNormalsOf(x::Format) = twopowm1(PrecisionOf(x)) * Emax_finite(x)

nNegativeNormalsOf(::UnsignedFormat) = 0
nNegativeNormalsOf(x::SignedFormat) = nPositiveNormalsOf(x)

nNormalsOf(x::Format) = SignMultiplicityOf(x) * nPositiveNormalsOf(x)

Emax_finite(x::SignedFormat) = twopow_expbits(x) - 0x01 - isone(PrecisionOf(x))
Emax_finite(x::UnsignedFormat) = twopow_expbits(x) - 0x01 - (PrecisionOf(x) <= 2)

twopow_expbits(x::Format) = twopow(ExponentFieldBitsOf(x))
