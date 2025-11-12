using Base: @kwdef

@kwdef struct AIFloat{T, Σ, Δ}       # Σ ∈ {:signed, :unsigned} 
                                     # Δ ∈ {:finite, :extended}
  bitwidth  ::Int                    # total bits
  precision ::Int                    # all significant bits
  frac_bits ::Int= precision-1       # trailing significand bits

  n_values ::Int= 2^bitwidth         # how many values
  n_fracs  ::Int= 2^frac_bits        # how many fractions

  exp_bits ::Int=    bitwidth - precision + (Σ == :unsigned)
  exp_bias ::Int= 2^(bitwidth - precision - (Σ == :signed) )
end
