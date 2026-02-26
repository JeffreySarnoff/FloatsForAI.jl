const Large1 = one(Int128)
const Large2 = Int128(2)
const Large3 = Int128(3)
const Large4 = Int128(4)

const ExpMIF64 = exponent(maxintfloat(Float64)) # 53

const MaybeBool = Union{Bool, Nothing}


#=
WuOf(x::Format) = BitwidthOf(x) - PrecisionOf(x)
WuOfm1(x::Format) = BitwidthOf(x) - PrecisionOf(x) - 1

function pow2WuOf(x::Format)
    wu = WuOf(x)
    (wu < ExpMIF64 ? 2^wu : Large2^wu)
end

function pow2WuOfm1(x::Format)
    wu = WuOfm1(x)
    (wu < ExpMIF64 ? 2^wu : Large2^wu)
end
=#

function twopow(x::I) where {I<:Integer}
    (x < ExpMIF64 ? 2 : Large2)^x
end

function twopowm1(x::I) where {I<:Integer}
    (x < ExpMIF64 ? 2 : Large2)^(x - 1)
end
