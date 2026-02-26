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

nNegativeSubnormalsOf(x::Format) = is_signed(x) * nPositiveSubnormalsOf(x)

nSubnormalsOf(x::Format) = twopow(PrecisionOf(x) - is_unsigned(x)) - 1 - is_signed(x)

nPrenormalsOf(x::Format) = nSubnormalsOf(x) + 1
nNonnegativePrenormalsOf(x::Format) = nPositiveSubnormalsOf(x) + 1
nNonpositivePrenormalsOf(x::Format) = nNegativeSubnormalsOf(x) + 1

nNormalsOf(x::Format) = nFinitesOf(x) - nPrenormalsOf(x)
nPositiveNormalsOf(x::Format) = nPositiveFinitesOf(x) - nNonnegativePrenormalsOf(x)
nNegativeNormalsOf(x::Format) = is_signed(x) * nPositiveNormalsOf(x)






