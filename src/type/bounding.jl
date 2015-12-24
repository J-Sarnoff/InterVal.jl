"""Boundary Bools"""

#=
   Boundary Bools
                                            lo  hi       lo     hi
        false  ⇋  a  Closed bound            ClOp   ⇋  (false, true)
        true   ⇋  an Open   bound            OpOp   ⇋  (true , true)
=#

const PairedBoundaryTypes = [ ClCl, OpCl, ClOp, OpOp ]

""" obtains a pair of boundary bools from a paired boundary type """
@inline boundaries(::Type{ClCl}) = (false, false)
@inline boundaries(::Type{ClOp}) = (false, true )
@inline boundaries(::Type{OpCl}) = (true,  false)
@inline boundaries(::Type{OpOp}) = (true,  true )

""" obtains a paired boundary type from a pair of boundary bools """
boundaries{B<:Bool}(lo::B,hi::B) =
   PairedBoundaryTypes[ one(Int8)+reinterpret(Int8,lo)+(reinterpret(Int8,hi)<<1) ]

""" obtains a paired boundary type, the unary negation of a paired boundary type"""
@inline negate(::Type{ClCl}) = ClCl
@inline negate(::Type{ClOp}) = OpCl
@inline negate(::Type{OpCl}) = ClOp
@inline negate(::Type{OpOp}) = OpOp


