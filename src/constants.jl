const Large2 = Int128(2)

const ExpMIF64 = exponent(maxintfloat(Float64)) # 53

const MaybeBool = Union{Bool, Nothing}

function twopow(x::I) where {I<:Integer}
    (x < ExpMIF64 ? 2 : Large2)^x
end

function twopowm1(x::I) where {I<:Integer}
    (x < ExpMIF64 ? 2 : Large2)^(x - 1)
end
