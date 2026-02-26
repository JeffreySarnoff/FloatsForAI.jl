nNaNsOf(x::Format) = 1
nZerosOf(x::Format) = 1
nInfsOf(x::Format) = is_finite(x) ? 0 : (1 + is_signed(x))

nValuesOf(x::Format) = let K = BitwidthOf(x);
    K < ExpMIF64 ? 2^K : Large2^K
end
  
nNumericValuesOf(x::Format) = nValuesOf(x) - 1
nNonFinitesOf(x::Format) = nNaNsOf(x) + nInfsOf(x)
nFinitesOf(x::Format) = nValuesOf(x) - nNonFinitesOf(x)
nNonzeroFinitesOf(x::Format) = nFinitesOf(x) - nZerosOf(x)

nStrictlyPositiveFinitesOf(x::Format) = nNonzeroFinitesOf(x) >> is_signed(x)
nNegativeFinitesOf(x::Format) = is_signed(x) * nStrictlyPositiveFinitesOf(x)
nNonnegativeFinitesOf(x::Format) = nStrictlyPositiveFinitesOf(x) + 1



