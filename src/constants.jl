import Base: convert, Int

const Large1 = one(Int128)
const Large2 = Int128(2)
const Large3 = Int128(3)
const Large4 = Int128(4)

const ExpMIF64 = exponent(maxintfloat(Float64)) # 53

const MaybeBool = Union{Bool, Nothing}
