using AIFloats, Test

include("macros.jl")

UF(bitwidth, precision) = UnsignedFinite(bitwidth, precision; T=Float32)
ufseq(bitwidth, precision) = valueseq(UF(bitwidth, precision))

UE(bitwidth, precision) = UnsignedExtended(bitwidth, precision; T=Float32)
ueseq(bitwidth, precision) = valueseq(UE(bitwidth, precision))

SF(bitwidth, precision) = SignedFinite(bitwidth, precision; T=Float32)
sfseq(bitwidth, precision) = valueseq(SF(bitwidth, precision))

SE(bitwidth, precision) = SignedExtended(bitwidth, precision; T=Float32)
seseq(bitwidth, precision) = valueseq(SE(bitwidth, precision))


Binary4p1ue = UE(4,1); Binary4p1ue_values = ueseq(4,1);
Binary4p1uf = UF(4,1); Binary4p1ue_values = ufseq(4,1);
Binary4p1se = SE(4,1); Binary4p1se_values = seseq(4,1);
Binary4p1sf = SF(4,1); Binary4p1sf_values = sfseq(4,1);

Binary4p2ue = UE(4,2); Binary4p2ue_values = ueseq(4,2);
Binary4p2uf = UF(4,2); Binary4p2ue_values = ufseq(4,2);
Binary4p2se = SE(4,2); Binary4p2se_values = seseq(4,2);
Binary4p2sf = SF(4,2); Binary4p2sf_values = sfseq(4,2);

Binary4p3ue = UE(4,3); Binary4p3ue_values = ueseq(4,3);
Binary4p3uf = UF(4,3); Binary4p3ue_values = ufseq(4,3);
Binary4p3se = SE(4,3); Binary4p3se_values = seseq(4,3);
Binary4p3sf = SF(4,3); Binary4p3sf_values = sfseq(4,3);

Binary4p4ue = UE(4,4); Binary4p4ue_values = ueseq(4,4);
Binary4p4uf = UF(4,4); Binary4p4ue_values = ufseq(4,4);
