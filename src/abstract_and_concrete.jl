  valuetype(::AIFloat{T, Σ, Δ})  where {T, Σ, Δ} =  T

  is_signed(::AIFloat{T, Σ, Δ}) where {T, Σ, Δ} =  Σ === :signed
is_unsigned(::AIFloat{T, Σ, Δ}) where {T, Σ, Δ} =  Σ === :unsigned

  is_finite(::AIFloat{T, Σ, Δ}) where {T, Σ, Δ} =  Δ === :finite
is_extended(::AIFloat{T, Σ, Δ}) where {T, Σ, Δ} =  Δ === :extended

abstract_functions = 
     (:valuetype, :is_signed, :is_unsigned, :is_finite, :is_extended)

for F in abstract_functions
   @eval $F(x) = $F(typeof(x))
end

#= 
    now this just works

Binary8p3se = SignedExtended(8, 3)
is_signed(Binary8p3se) && !is_finite(Binary8p3se) 
=#