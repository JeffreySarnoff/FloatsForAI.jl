codetype(x::Format) = uitype(BitwidthOf(x))
uitype(n::I) where {I<:Integer} = iszro(n >> 0x08) ? UInt8 : UInt16

function allcodepoints(x::Format)
   ui = codetype(x)
   cp0 = zero(ui)
   cp1 = one(ui)
   cpM = ui(nValuesOf(x)) - cp1
   Tuple(cp0 + i*cp1 for i in 0:cpM)
end

codepoint_zero(x::Format) = zero(codetype(x))
codepoint_one(x::Format) = twopowm1(BitwidthOf(x) - is_signed(x))
codepoint_nan(x::UnsignedFormat) = twopow(BitwidthOf(x)) - 0x01
codepoint_nan(x::SignedFormat)   = twopowm1(BitwidthOf(x))

