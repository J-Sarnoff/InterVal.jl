function (sqrt){G<:Grasp,R<:Real}(a::Rvl{G,R})
    lo = (sqrt)(a.lo, RoundDown)
    hi = (sqrt)(a.hi, RoundUp)
    Rvl{G,R}(lo, hi)
end

