module FloatsForAI

export AIFloat, codes, values

include("construct/struct.jl")
include("construct/constructors.jl")
include("construct/abstract.jl")
include("construct/concrete.jl")

include("code_sequence.jl")
include("value_sequence.jl")
include("value_support/expseq.jl")
include("value_support/fracseq.jl")
include("value_support/intseq.jl")


end # module FloatsForAI
