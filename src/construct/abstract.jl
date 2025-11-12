  valuetype(::AIFloat{T, Σ, Δ})  where {T, Σ, Δ} =  T

  is_signed(x::AIFloat{T, Σ, Δ}) where {T, Σ, Δ} =  Σ === :signed
is_unsigned(x::AIFloat{T, Σ, Δ}) where {T, Σ, Δ} =  Σ === :unsigned

  is_finite(x::AIFloat{T, Σ, Δ}) where {T, Σ, Δ} =  Δ === :finite
is_extended(x::AIFloat{T, Σ, Δ}) where {T, Σ, Δ} =  Δ === :extended
