@inline function (-){G<:Grasp,R<:Real}(a::Rvl{G,R})
   Rvl{negate(G), R}(-a.hi, -a.lo)
end

function (-){G1<:Grasp,G2<:Grasp,R<:Real}(a::Rvl{G1,R}, b::Rvl{G2,R})
    aLoIsOpen, aHiIsOpen = boundaries(G1)
    bLoIsOpen, bHiIsOpen = boundaries(G2)

    abGrasp = boundaries( (aLoIsOpen|bHiIsOpen), (aHiIsOpen|bLoIsOpen) )

    lo = (-)(a.lo, b.hi, RoundDown)
    hi = (-)(a.hi, b.lo, RoundUp)

    Rvl{abGrasp,R}(lo, hi)
end

(-){G<:Grasp,R<:Real}(a::Rvl{G,R}, b::R) = (-)(a, Rvl{G,R}(b))
(-){G<:Grasp,R<:Real}(a::R, b::Rvl{G,R}) = (-)(Rvl{G,R}(a), b)

(-){G<:Grasp,I<:WorkInt}(a::Rvl{G,Float64}, b::I) = (-)(a, Rvl{G,Float64}(convert(Float64,b)))
(-){G<:Grasp,I<:WorkInt}(a::I, b::Rvl{G,Float64}) = (-)(Rvl{G,Float64}(convert(Float64,a)), b)
(-){G<:Grasp,I<:WorkInt}(a::Rvl{G,Float32}, b::I) = (-)(a, Rvl{G,Float32}(convert(Float32,b)))
(-){G<:Grasp,I<:WorkInt}(a::I, b::Rvl{G,Float32}) = (-)(Rvl{G,Float32}(convert(Float32,a)), b)
