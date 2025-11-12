UnsignedFinite(bitwidth::Int, precision::Int; T=Float32)   =
    AIFloat{T, :unsigned, :finite  }(; bitwidth, precision)

UnsignedExtended(bitwidth::Int, precision::Int; T=Float32) =
    AIFloat{T, :unsigned, :extended}(; bitwidth, precision)

SignedFinite(bitwidth::Int, precision::Int; T=Float32)     =
    AIFloat{T, :signed, :finite  }(; bitwidth, precision)

SignedExtended(bitwidth::Int, precision::Int; T=Float32)   =
    AIFloat{T, :signed, :extended}(; bitwidth, precision)

function AIFloat(bitwidth::Int, precision::Int, Σ::Symbol, Δ::Symbol; T=Float32)
    if     Σ == :unsigned && Δ == :finite
        UnsignedFinite(bitwidth, precision; T)
    elseif Σ == :unsigned && Δ == :extended
        UnsignedExtended(bitwidth, precision; T)
    elseif Σ == :signed && Δ == :finite
        SignedFinite(bitwidth, precision; T)
    elseif Σ == :signed && Δ == :extended
        SignedExtended(bitwidth, precision; T)
    else
        if Σ ∉ (:unsigned, :signed)
            error("Invalid signedness: $Σ")
        else
            error("Invalid domain: $Δ")
        end
    end
end
