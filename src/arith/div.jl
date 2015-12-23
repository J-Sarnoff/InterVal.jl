#=
    There are six general cases for processing a/b (when b excludes 0)
    and six special cases (where the denominator includes 0 as a bound)
    and two exceptional cases (where the denominator is 0 or straddles 0)
                  b <= 0       b >= 0
       a <=  0    LteLte       LteGte
       a <0< a    ZerLte       ZerGte
       a >=  0    GteLte       GteGte
=#


function (/){G<:Grasp,W<:Grasp,R<:Real}(a::Rvl{G,R}, b::Rvl{W,R})
    z = zero(R)
    if (b.lo == z) | (b.hi == z) | ((b.lo < z) & (b.hi > z))
      divisorContainsZero(a,b)
   elseif a.hi <= z
       if     b.hi <= z
           divLteLte(a,b)
       else # b.lo.fp >= z
           divLteGte(a,b)
       end
   elseif a.lo >= z
       if     b.hi <= z
           divGteLte(a,b)
       else # b.lo >= 0
           divGteGte(a,b)
       end
   else   # a straddles 0
       if     b.hi <= z
           divZerLte(a,b)
       else # b.lo >= 0
           divZerGte(a,b)
       end
   end
end

for (fn,loa,lob,hia,hib) in [ (:divLteLte, :(a.hi), :(b.lo), :(a.lo), :(b.hi)),
                              (:divLteGte, :(a.lo), :(b.lo), :(a.hi), :(b.hi)),
                              (:divGteLte, :(a.hi), :(b.hi), :(a.lo), :(b.lo)),
                              (:divGteGte, :(a.lo), :(b.hi), :(a.hi), :(b.lo)),
                              (:divZerLte, :(a.hi), :(b.hi), :(a.lo), :(b.hi)),
                              (:divZerGte, :(a.lo), :(b.lo), :(a.hi), :(b.lo)),
                            ]
  @eval begin
    function ($fn){G<:Grasp,W<:Grasp,R<:Real}(a::Rvl{G,R}, b::Rvl{W,R})
        aLoIsOpen, aHiIsOpen = boundries(T)
        bLoIsOpen, bHiIsOpen = boundries(W)
        cType = boundries( (aLoIsOpen|bLoIsOpen), (aHiIsOpen|bHiIsOpen) )

        lo = (/)(($loa), ($lob), RoundDown)
        hi = (/)(($hia), ($hib), RoundUp)

        Rvl{cType,R}(lo, hi)
    end
  end
end


(/){G<:Grasp,R<:Real}(a::Rvl{G,R}, b::R) = (/)(a, Rvl{G,R}(b))
(/){G<:Grasp,R<:Real}(a::R, b::Rvl{G,R}) = (/)(Rvl{G,R}(a), b)

(/){G<:Grasp,F<:WorkInt}(a::Rvl{G,Float64}, b::F) = (/)(a, Rvl{G,Float64}(convert(Float64,b)))
(/){G<:Grasp,F<:WorkInt}(a::F, b::Rvl{G,Float64}) = (/)(Rvl{G,Float64}(convert(Float64,a)), b)
(/){G<:Grasp,F<:WorkInt}(a::Rvl{G,Float32}, b::F) = (/)(a, Rvl{G,Float32}(convert(Float32,b)))
(/){G<:Grasp,F<:WorkInt}(a::F, b::Rvl{G,Float32}) = (/)(Rvl{G,Float32}(convert(Float32,a)), b)


