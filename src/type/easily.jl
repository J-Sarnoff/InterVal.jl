typealias WorkInt Union{Int64, Int32}

ClCl{R<:Real}(x::Rvl{ClCl,R}) = x
ClOp{R<:Real}(x::Rvl{ClCl,R}) = Rvl{ClOp,R}(x.lo,nextFloat(x.hi))
OpCl{R<:Real}(x::Rvl{ClCl,R}) = Rvl{OpCl,R}(prevFloat(x.lo),x.hi)
OpOp{R<:Real}(x::Rvl{ClCl,R}) = Rvl{OpOp,R}(prevFloat(x.lo),nextFloat(x.hi))

ClCl{R<:Real}(x::Rvl{ClOp,R}) = Rvl{ClCl,R}(x.lo,x.hi)
ClOp{R<:Real}(x::Rvl{ClOp,R}) = x
OpCl{R<:Real}(x::Rvl{ClOp,R}) = Rvl{OpCl,R}(prevFloat(x.lo),x.hi)
OpOp{R<:Real}(x::Rvl{ClOp,R}) = Rvl{OpOp,R}(prevFloat(x.lo),x.hi)

ClCl{R<:Real}(x::Rvl{OpCl,R}) = Rvl{ClCl,R}(x.lo,x.hi)
ClOp{R<:Real}(x::Rvl{OpCl,R}) = Rvl{ClOp,R}(x.lo,nextFloat(x.hi))
OpCl{R<:Real}(x::Rvl{OpCl,R}) = x
OpOp{R<:Real}(x::Rvl{OpCl,R}) = Rvl{OpOp,R}(x.lo,nextFloat(x.hi))

ClCl{R<:Real}(x::Rvl{OpOp,R}) = Rvl{ClCl,R}(x.lo,x.hi)
ClOp{R<:Real}(x::Rvl{OpOp,R}) = Rvl{ClOp,R}(x.lo,x.hi)
OpCl{R<:Real}(x::Rvl{OpOp,R}) = Rvl{OpCl,R}(x.lo,x.hi)
OpOp{R<:Real}(x::Rvl{OpOp,R}) = x

ClCl!{G<:Grasp,R<:Real}(x::Rvl{G,R}) = ClCl(x.lo,x.hi)
ClOp!{G<:Grasp,R<:Real}(x::Rvl{G,R}) = ClOp(x.lo,x.hi)
OpCl!{G<:Grasp,R<:Real}(x::Rvl{G,R}) = OpCl(x.lo,x.hi)
OpOp!{G<:Grasp,R<:Real}(x::Rvl{G,R}) = OpOp(x.lo,x.hi)
