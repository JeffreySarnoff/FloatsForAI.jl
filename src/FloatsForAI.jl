module FloatsForAI

export AIFloat, codes, values
export Format, Signedness, Domain, MaybeBool,
       is_unsigned, is_signed, is_finite, is_extended,
       BitwidthOf, PrecisionOf, TrailingBitsOf, SignBitsOf,
       ExponentBitsOf, ExponentFieldBitsOf, 
       ExponentBiasOf, ExponentMinOf, ExponentMaxOf,
       SignMultiplicityOf, twopow, twopowm1
export nNaNsOf, nZerosOf, nInfsOf,
       nValuesOf, nNumericValuesOf, nNonFinitesOf, nFinitesOf, nNonzeroFinitesOf,
       nPositiveFinitesOf, nNegativeFinitesOf, nNonnegativeFinitesOf,
       nPrenormalsOf, nNonnegativePrenormalsOf, nNonpositivePrenormalsOf,
       nPosititveSubnormalsOf, nNegativeSubnormalsOf, nSubnormalsOf,
       nPositiveNormalsOf, nNegativeNormalsOf, nNormalsOf


import Base: convert, Int
using Quadmath: Float128

include("constants.jl")
include("types.jl")
include("counts.jl")

#=
include("constructors.jl")
include("abstract_and_concrete.jl")

include("codes_and_values.jl")
include("zero_and_larger_values.jl")
=#

end # module FloatsForAI








