"""
Intervals (Rvls) have two boundaries, each one has *value* and *reach*
*value* is a Float represented quantity.
*reach* is Closed or Open.
"""

abstract AbstractInterval       <: Real
abstract Boundary               <: AbstractInterval
abstract BoundingValue             <: Boundary       # reserved, not used
abstract Grasp                     <: Boundary       # configuration of bounding extrema
                                                     # e.g. ClOp for lobound Closed, hibound Open)

type Self  <: Grasp end

type ClCl  <: Grasp end
type ClOp  <: Grasp end
type OpCl  <: Grasp end
type OpOp  <: Grasp end


# Rvl --> Intrvl, Irvl --> Rvl (ravel)

immutable Rvl{G<:Grasp, R<:Real} <: Real
    lo::R
    hi::R
end

typealias Rvl
lowerbound{G<:Grasp, R<:Real}(x::Rvl{G,R}) = x.lo
upperbound{G<:Grasp, R<:Real}(x::Rvl{G,R}) = x.hi

#=
aClCl = Rvl{ClCl,Float64}(1.0,2.0); aClCl == ClCl(1.0,2.0)
aOpCl = Rvl{OpCl,Float64}(1.0,2.0); aOpCl == OpCl(1.0,2.0)
aClOp = Rvl{ClOp,Float64}(1.0,2.0); aClOp == ClOp(1.0,2.0)
aOpOp = Rvl{OpOp,Float64}(1.0,2.0); aOpOp == OpOp(1.0,2.0)
=#

for B in (:Self, :ClCl, :ClOp, :OpCl, :OpOp)
  @eval begin
     function convert{R<:Real}(::Type{Rvl{($B),R}}, lo::R, hi::R)
        lo, hi = minmax(lo, hi)
        Rvl{$B,R}(lo,hi)
     end
     convert{R<:Real}(::Type{Rvl{($B),R}}, x::R) = convert(Rvl($B,R), x,x)
     function ($B){R<:Real}(lo::R, hi::R)
        lo, hi = minmax(lo, hi)
        Rvl{$B,R}(lo,hi)
     end
     function ($B){R1<:Real,R2<:Real}(lo::R1, hi::R2)
        ($B)(promote(lo,hi)...)
     end
     function ($B){R<:Real}(x::R)
        Rvl{$B,R}(x,x)
     end
  end
end

