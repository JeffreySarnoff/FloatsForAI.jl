using AIFloats, Test

include(joinpath(@__DIR__,"..","test","macros.jl"))

function format_name(AIF::AIFloat{T,Σ,Δ})
    sigma = is_unsigned(AIF) ? "u" : "s"
    delta = is_finite(AIF) ? "f" : "e"
    Symbol(string("Binary", AIF.bitwidth, "P", AIF.precision, sigma, delta))
end

function values_name(AIF::AIFloat{T,Σ,Δ}) where {T,Σ,Δ}
    sigma = is_unsigned(AIF) ? "u" : "s"
    delta = is_finite(AIF) ? "f" : "e"
    name = Symbol(string(sigma, delta, "K", AIF.bitwidth, "P", AIF.precision))
    vals = values(AIF)
    @assign(name, vals)
end

maxbits = 6
T = Float64
for Δ in (:finite, :extended)
    for bitwidth in 2:maxbits
        Σ = :unsigned
        for precision in 1:bitwidth
            AIF = AIFloat{T,Σ,Δ}(bitwidth, precision)
            assign(format_name(AIF), AIF)
            aiAIvalues = values(AIF)
        end
        Σ = :signed
        for precision in 1:bitwidth-1
            AIF = AIFloat{T,Σ,Δ}(bitwidth, precision)
            assign(format_name(AIF), AIF)
        end
    end
end



                
                for AIF in (AIFloat{T,Σ,Δ}(bitwidth, precision))
assign(format_name(AIF), AIF)i

evaluesAIFloat(bitwidth, precision, Σ, Δ; T=Float64)


UF(bitwidth, precision) = FloatsForAI.AIFloat(bitwidth, precision, :unsigned, :finite; T=Float32)
ufseq(bitwidth, precision) = valueseq(UF(bitwidth, precision))

UE(bitwidth, precision) = FloatsForAI.AIFloat(bitwidth, precision, :unsigned, :extended; T=Float32)
ueseq(bitwidth, precision) = valueseq(UE(bitwidth, precision))

SF(bitwidth, precision) = FloatsForAI.AIFloat(bitwidth, precision, :signed, :finite; T=Float32)
sfseq(bitwidth, precision) = valueseq(SF(bitwidth, precision))

SE(bitwidth, precision) = FloatsForAI.AIFloat(bitwidth, precision, :signed, :extended; T=Float32)
seseq(bitwidth, precision) = valueseq(SE(bitwidth, precision))


Binary4p1ue = UE(4,1); Binary4p1ue_values = ueseq(4,1);
Binary4p1uf = UF(4,1); Binary4p1uf_values = ufseq(4,1);
Binary4p1se = SE(4,1); Binary4p1se_values = seseq(4,1);
Binary4p1sf = SF(4,1); Binary4p1sf_values = sfseq(4,1);

Binary4p2ue = UE(4,2); Binary4p2ue_values = ueseq(4,2);
Binary4p2uf = UF(4,2); Binary4p2uf_values = ufseq(4,2);
Binary4p2se = SE(4,2); Binary4p2se_values = seseq(4,2);
Binary4p2sf = SF(4,2); Binary4p2sf_values = sfseq(4,2);

Binary4p3ue = UE(4,3); Binary4p3ue_values = ueseq(4,3);
Binary4p3uf = UF(4,3); Binary4p3uf_values = ufseq(4,3);
Binary4p3se = SE(4,3); Binary4p3se_values = seseq(4,3);
Binary4p3sf = SF(4,3); Binary4p3sf_values = sfseq(4,3);

Binary4p4ue = UE(4,4); Binary4p4ue_values = ueseq(4,4);
Binary4p4uf = UF(4,4); Binary4p4uf_values = ufseq(4,4);


Binary5p1ue = UE(5,1); Binary5p1ue_values = ueseq(5,1);
Binary5p1uf = UF(5,1); Binary5p1uf_values = ufseq(5,1);
Binary5p1se = SE(5,1); Binary5p1se_values = seseq(5,1);
Binary5p1sf = SF(5,1); Binary5p1sf_values = sfseq(5,1);

Binary5p2ue = UE(5,2); Binary5p2ue_values = ueseq(5,2);
Binary5p2uf = UF(5,2); Binary5p2uf_values = ufseq(5,2);
Binary5p2se = SE(5,2); Binary5p2se_values = seseq(5,2);
Binary5p2sf = SF(5,2); Binary5p2sf_values = sfseq(5,2);

Binary5p3ue = UE(5,3); Binary5p3ue_values = ueseq(5,3);
Binary5p3uf = UF(5,3); Binary5p3uf_values = ufseq(5,3);
Binary5p3se = SE(5,3); Binary5p3se_values = seseq(5,3);
Binary5p3sf = SF(5,3); Binary5p3sf_values = sfseq(5,3);

Binary5p3ue = UE(5,3); Binary5p3ue_values = ueseq(5,3);
Binary5p3uf = UF(5,3); Binary5p3uf_values = ufseq(5,3);
Binary5p3se = SE(5,3); Binary5p3se_values = seseq(5,3);
Binary5p3sf = SF(5,3); Binary5p3sf_values = sfseq(5,3);

Binary5p4ue = UE(5,4); Binary5p4ue_values = ueseq(5,4);
Binary5p4uf = UF(5,4); Binary5p4uf_values = ufseq(5,4);
Binary5p4se = SE(5,4); Binary5p4se_values = seseq(5,4);
Binary5p4sf = SF(5,4); Binary5p4sf_values = sfseq(5,4);

Binary5p5ue = UE(5,5); Binary5p5ue_values = ueseq(5,5);
Binary5p5uf = UF(5,5); Binary5p5uf_values = ufseq(5,5);


Binary6p1ue = UE(6,1); Binary6p1ue_values = ueseq(6,1);
Binary6p1uf = UF(6,1); Binary6p1uf_values = ufseq(6,1);
Binary6p1se = SE(6,1); Binary6p1se_values = seseq(6,1);
Binary6p1sf = SF(6,1); Binary6p1sf_values = sfseq(6,1);

Binary6p2ue = UE(6,2); Binary6p2ue_values = ueseq(6,2);
Binary6p2uf = UF(6,2); Binary6p2uf_values = ufseq(6,2);
Binary6p2se = SE(6,2); Binary6p2se_values = seseq(6,2);
Binary6p2sf = SF(6,2); Binary6p2sf_values = sfseq(6,2);

Binary6p3ue = UE(6,3); Binary6p3ue_values = ueseq(6,3);
Binary6p3uf = UF(6,3); Binary6p3uf_values = ufseq(6,3);
Binary6p3se = SE(6,3); Binary6p3se_values = seseq(6,3);
Binary6p3sf = SF(6,3); Binary6p3sf_values = sfseq(6,3);

Binary6p3ue = UE(6,3); Binary6p3ue_values = ueseq(6,3);
Binary6p3uf = UF(6,3); Binary6p3uf_values = ufseq(6,3);
Binary6p3se = SE(6,3); Binary6p3se_values = seseq(6,3);
Binary6p3sf = SF(6,3); Binary6p3sf_values = sfseq(6,3);

Binary6p4ue = UE(6,4); Binary6p4ue_values = ueseq(6,4);
Binary6p4uf = UF(6,4); Binary6p4uf_values = ufseq(6,4);
Binary6p4se = SE(6,4); Binary6p4se_values = seseq(6,4);
Binary6p4sf = SF(6,4); Binary6p4sf_values = sfseq(6,4);

Binary6p5ue = UE(6,5); Binary6p5ue_values = ueseq(6,5);
Binary6p5uf = UF(6,5); Binary6p5uf_values = ufseq(6,5);
Binary6p5se = SE(6,5); Binary6p5se_values = seseq(6,5);
Binary6p5sf = SF(6,5); Binary6p5sf_values = sfseq(6,5);

Binary6p6ue = UE(6,6); Binary6p6ue_values = ueseq(6,6);
Binary6p6uf = UF(6,6); Binary6p6uf_values = ufseq(6,6);

Binary7p1ue = UE(7,1); Binary7p1ue_values = ueseq(7,1);
Binary7p1uf = UF(7,1); Binary7p1uf_values = ufseq(7,1);
Binary7p1se = SE(7,1); Binary7p1se_values = seseq(7,1);
Binary7p1sf = SF(7,1); Binary7p1sf_values = sfseq(7,1);

Binary7p2ue = UE(7,2); Binary7p2ue_values = ueseq(7,2);
Binary7p2uf = UF(7,2); Binary7p2uf_values = ufseq(7,2);
Binary7p2se = SE(7,2); Binary7p2se_values = seseq(7,2);
Binary7p2sf = SF(7,2); Binary7p2sf_values = sfseq(7,2);

Binary7p3ue = UE(7,3); Binary7p3ue_values = ueseq(7,3);
Binary7p3uf = UF(7,3); Binary7p3uf_values = ufseq(7,3);
Binary7p3se = SE(7,3); Binary7p3se_values = seseq(7,3);
Binary7p3sf = SF(7,3); Binary7p3sf_values = sfseq(7,3);

Binary7p3ue = UE(7,3); Binary7p3ue_values = ueseq(7,3);
Binary7p3uf = UF(7,3); Binary7p3uf_values = ufseq(7,3);
Binary7p3se = SE(7,3); Binary7p3se_values = seseq(7,3);
Binary7p3sf = SF(7,3); Binary7p3sf_values = sfseq(7,3);

Binary7p4ue = UE(7,4); Binary7p4ue_values = ueseq(7,4);
Binary7p4uf = UF(7,4); Binary7p4uf_values = ufseq(7,4);
Binary7p4se = SE(7,4); Binary7p4se_values = seseq(7,4);
Binary7p4sf = SF(7,4); Binary7p4sf_values = sfseq(7,4);

Binary7p5ue = UE(7,5); Binary7p5ue_values = ueseq(7,5);
Binary7p5uf = UF(7,5); Binary7p5uf_values = ufseq(7,5);
Binary7p5se = SE(7,5); Binary7p5se_values = seseq(7,5);
Binary7p5sf = SF(7,5); Binary7p5sf_values = sfseq(7,5);

Binary7p6ue = UE(7,6); Binary7p6ue_values = ueseq(7,6);
Binary7p6uf = UF(7,6); Binary7p6uf_values = ufseq(7,6);
Binary7p6se = SE(7,6); Binary7p6se_values = seseq(7,6);
Binary7p6sf = SF(7,6); Binary7p6sf_values = sfseq(7,6);

Binary7p7ue = UE(7,7); Binary7p7ue_values = ueseq(7,7);
Binary7p7uf = UF(7,7); Binary7p7uf_values = ufseq(7,7);
