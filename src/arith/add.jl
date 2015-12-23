function (+){G<:Grasp,W<:Grasp,R<:Real}(a::Rvl{G,R}, b::Rvl{W,R})
    aLoIsOpen, aHiIsOpen = boundries(G)
    bLoIsOpen, bHiIsOpen = boundries(W)

    cType = boundries( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

    lo = (+)(a.lo, b.lo, RoundDown)
    hi = (+)(a.hi, b.hi, RoundUp)

    Rvl{cType,F}(lo, hi)
end

(+){G<:Grasp,R<:Real}(a::Rvl{G,R}, b::F) = (+)(a, Rvl{G,R}(b))
(+){G<:Grasp,R<:Real}(a::F, b::Rvl{G,R}) = (+)(Rvl{G,R}(a), b)

(+){G<:Grasp,F<:WorkInt}(a::Rvl{G,Float64}, b::F) = (+)(a, Rvl{G,Float64}(convert(Float64,b)))
(+){G<:Grasp,F<:WorkInt}(a::F, b::Rvl{G,Float64}) = (+)(Rvl{G,Float64}(convert(Float64,a)), b)
(+){G<:Grasp,F<:WorkInt}(a::Rvl{G,Float32}, b::F) = (+)(a, Rvl{G,Float32}(convert(Float32,b)))
(+){G<:Grasp,F<:WorkInt}(a::F, b::Rvl{G,Float32}) = (+)(Rvl{G,Float32}(convert(Float32,a)), b)
