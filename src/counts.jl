nValuesOf(x::Format) = let K = BitwidthOf(x);
    K < ExpMIF64 ? 2^K : Large2^K
end
  
