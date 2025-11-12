abstract_functions = 
     (:valuetype, :is_signed, :is_unsigned, :is_finite, :is_extended)

for F in abstract_functions
   @eval $F(x) = $F(typeof(x))
end

# now this just works

Binary8p3se = SignedExtended(8, 3)

is_signed(Binary8p3se) && !is_finite(Binary8p3se) 