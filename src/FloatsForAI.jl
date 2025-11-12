module FloatsForAI

export AIFloat, valueseq

# cd(s"C:\Users\Custom PC\Documents\Presentations\CoNGA-2025\FloatsForAI.jl\src")

include("construct/struct.jl")
include("construct/constructors.jl")
include("construct/abstract.jl")
include("construct/concrete.jl")

include("valueseq/sequence.jl")
include("valueseq/expseq.jl")
include("valueseq/fracseq.jl")
include("valueseq/intseq.jl")

function code_seq(x::AIFloat)
    n = x.n_values
    T = x.bitwidth <= 8  ? UInt8  :
        x.bitwidth <= 16 ? UInt16 :
        x.bitwidth <= 32 ? UInt32 :
                           UInt64
    return map(T, collect(0:n-1))
end

end # module FloatsForAI

