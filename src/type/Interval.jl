"""
Intervals have two boundaries, each one has *value* and *reach*
*value* is a Float represented quantity.
*reach* is Closed or Open.
"""

abstract AbstractInterval    <: Real
abstract Boundary               <: AbstractInterval
abstract BoundingValue             <: Boundary       # reserved, not used
abstract Grasp                     <: Boundary       # configuration of bounding extrema
                                                     # e.g. ClOp for lobound Closed, hibound Open)

type Self  <: Grasp end

type ClCl  <: Grasp end
type ClOp  <: Grasp end
type OpCl  <: Grasp end
type OpOp  <: Grasp end



immutable Interval{G<:Grasp, R<:Real} <: Real
    lo::R
    hi::R
end

lowerbound{G<:Grasp, R<:Real}(x::Interval{G,R}) = x.lo
upperbound{G<:Grasp, R<:Real}(x::Interval{G,R}) = x.hi

#=
aClCl = Interval{ClCl,Float64}(1.0,2.0); aClCl == ClCl(1.0,2.0)
aOpCl = Interval{OpCl,Float64}(1.0,2.0); aOpCl == ClCl(1.0,2.0)
aClOp = Interval{ClOp,Float64}(1.0,2.0); aClOp == ClCl(1.0,2.0)
aOpOp = Interval{OpOp,Float64}(1.0,2.0); aOpOp == ClCl(1.0,2.0)
=#

for B in (:Self, :ClCl, :ClOp, :OpCl, :OpOp)
  @eval begin
     function ($B){R<:Real}(lo::R, hi::R)
        lo, hi = minmax(lo, hi)
        Interval{$B,R}(lo,hi)
     end
     function ($B){R<:Real}(x::R)
        Interval{$B,R}(x,x)
     end
  end
end


