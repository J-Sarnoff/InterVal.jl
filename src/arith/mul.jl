#=
    There are nine general cases for processing a*b
                   b <= 0    b <0< b    b >= 0
       a <=  0    LteLte      LteZer    LteGte
       a <0< a    ZerLte      ZerZer    ZerGte
       a >=  0    GteLte      GteZer    GteGte
=#

function (*){G<:Grasp,W<:Grasp,R<:Real}(a::Rvl{G,R}, b::Rvl{W,R})
    z = zero(R)
    if     a.hi <= z
       if     b.hi <= z
           mulLteLte(a,b)
       elseif b.lo >= z
           mulLteGte(a,b)
       else   # b straddles 0
           mulLteZer(a,b)
       end
    elseif a.lo >= z
       if     b.hi <= z
           mulGteLte(a,b)
       elseif b.lo >= z
           mulGteGte(a,b)
       else   # b straddles 0
           mulGteZer(a,b)
       end
    else   # a straddles 0
       if     b.hi <= z
           mulZerLte(a,b)
       elseif b.lo >= z
           mulZerGte(a,b)
       else   # b straddles 0
           mulZerZer(a,b)
       end
    end
end

for (fn,loa,lob,hia,hib) in [ (:mulLteLte, :(a.hi), :(b.hi), :(a.lo), :(b.lo)),
                              (:mulLteGte, :(a.lo), :(b.hi), :(a.hi), :(b.lo)),
                              (:mulLteZer, :(a.lo), :(b.hi), :(a.lo), :(b.lo)),
                              (:mulGteLte, :(a.hi), :(b.lo), :(a.lo), :(b.hi)),
                              (:mulGteGte, :(a.lo), :(b.lo), :(a.hi), :(b.hi)),
                              (:mulGteZer, :(a.hi), :(b.lo), :(a.hi), :(b.hi)),
                              (:mulZerLte, :(a.hi), :(b.lo), :(a.lo), :(b.lo)),
                              (:mulZerGte, :(a.lo), :(b.hi), :(a.hi), :(b.hi)),
                            ]
  @eval begin
    function ($fn){G<:Grasp,W<:Grasp,R<:Real}(a::Rvl{G,R}, b::Rvl{W,R})
        aLoIsOpen, aHiIsOpen = boundaries(T)
        bLoIsOpen, bHiIsOpen = boundaries(W)
        cType = boundaries( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

        lo = (*)(($loa), ($lob), RoundDown)
        hi = (*)(($hia), ($hib), RoundUp)

        Rvl{cType,R}(lo, hi)
    end
  end
end


(*){G<:Grasp,F<:AbstractFloat}(a::Rvl{G,F}, b::F) = (*)(a, Rvl{G,F}(b))
(*){G<:Grasp,F<:AbstractFloat}(a::F, b::Rvl{G,F}) = (*)(Rvl{G,F}(a), b)

(*){G<:Grasp,R<:Real}(a::Rvl{G,R}, b::R) = (*)(a, Rvl{G,R}(b))
# ambiguity with Bool
#(*){G<:Grasp,R<:Real}(a::R, b::Rvl{G,R}) = (*)(Rvl{G,R}(a), b)

(*){G<:Grasp,I<:WorkInt}(a::Rvl{G,Float64}, b::I) = (*)(a, Rvl{G,Float64}(convert(Float64,b)))
(*){G<:Grasp,I<:WorkInt}(a::I, b::Rvl{G,Float64}) = (*)(Rvl{G,Float64}(convert(Float64,a)), b)
(*){G<:Grasp,I<:WorkInt}(a::Rvl{G,Float32}, b::I) = (*)(a, Rvl{G,Float32}(convert(Float32,b)))
(*){G<:Grasp,I<:WorkInt}(a::I, b::Rvl{G,Float32}) = (*)(Rvl{G,Float32}(convert(Float32,a)), b)
