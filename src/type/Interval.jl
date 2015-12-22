"""
Intervals have two boundaries, each one has *value* and *reach*
*value* is a Float represented quantity.
*reach* is Closed or Open.
"""

abstract AbstractInterval    <: Real
abstract Boundary               <: AbstractInterval
abstract BoundingValue             <: Boundary       # reserved, not used
abstract BoundingDescriptor        <: Boundary

type Self  <: BoundingDescriptor end

type ClCl  <: BoundingDescriptor end
type ClOp  <: BoundingDescriptor end
type OpCl  <: BoundingDescriptor end
type OpOp  <: BoundingDescriptor end


immutable Interval{B<:BoundingDescriptor, T<:Real} <: Real
    lo::T
    hi::T
end

#=
aClCl = Interval{ClCl,Float64}(1.0,2.0)
aOpCl = Interval{OpCl,Float64}(1.0,2.0)
aClOp = Interval{ClOp,Float64}(1.0,2.0)
aOpOp = Interval{OpOp,Float64}(1.0,2.0)
=#

for B in (:Self, :ClCl, :ClOp, :OpCl, :OpOp)
  @eval begin
     function ($B){T<:Real}(lo::T, hi::T)
        lo, hi = minmax(lo, hi)
        Interval{$B,T}(lo,hi)
     end
     function ($B){T<:Real}(x::T)
        Interval{$B,T}(x,x)
     end
  end
end


