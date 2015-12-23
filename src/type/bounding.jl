"""Boundary Bools"""

#=
   Boundary Bools
                                            lo  hi       lo     hi
        false  ⇋  a  Closed bound            ClOp   ⇋  (false, true)
        true   ⇋  an Open   bound            OpOp   ⇋  (true , true)
=#

const PairedBoundaryTypes = [ ClCl, ClOp, OpCl, OpOp ]

""" obtains a pair of boundary bools from a paired boundary type """
@inline boundings(::Type{ClCl}) = (false, false)
@inline boundings(::Type{ClOp}) = (false, true )
@inline boundings(::Type{OpCl}) = (true,  false)
@inline boundings(::Type{OpOp}) = (true,  true )

""" obtains a paired boundary type from a pair of boundary bools """
boundings{B<:Bool}(lo::B,hi::B) =
   PairedBoundaryTypes[ one(Int8)+reinterpret(Int8,lo)+(reinterpret(Int8,hi)<<1) ]

""" obtains a paired boundary type, the unary negation of a paired boundary type"""
@inline negate(::Type{ClCl}) = ClCl
@inline negate(::Type{ClOp}) = OpCl
@inline negate(::Type{OpCl}) = ClOp
@inline negate(::Type{OpOp}) = OpOp


