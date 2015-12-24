#=
for (fn) in (:ClCl, :ClOp, :OpCl, :OpOp)
    @eval ($fn){R1<:Real, R2<:Real}(a::R1, b::R2) = ($fn)(promote(a,b)...)
end
=#

# grasp
# it takes values presumed exact 
# adjusting as needed for (from closedclosed into Grasp)
# so there is no risk of value exclusion 
# or
# it takes values as grasped
# and adjusts as needed (from Grasp into closedclosed)
# so there is no risk of value exclusion 
#
# grasped  yields a grasp_ed interval
# released yields a twice grasp_ed interval 

grasp{R<:Real}(::Type{ClCl}, a::R, b::R) = (a,b)
grasp{R<:Real}(::Type{ClOp}, a::R, b::R) = (a,nextfloat(b))
grasp{R<:Real}(::Type{OpCl}, a::R, b::R) = (prevfloat(a),b)
grasp{R<:Real}(::Type{OpOp}, a::R, b::R) = widen(a,b)

grasped{G<:Grasp, R<:Real}(::Type{G}, a::R, b::R) = Rvl{G,R}( grasp(::Type{G},a,b)... )
release{G<:Grasp, R<:Real}(::Type{G}, a::R, b::R) = grasp(::Type{G}, a, b)
release{G<:Grasp, R<:Real}(this::Rvl{G,R})  = release(::Type{G}, values(this)... )
released{G<:Grasp, R<:Real}(this::Rvl{G,R}) = Rvl{G,R}( release(::Type{G},a,b)... )



if ::isdefined(Main,:ValidatedNumerics)

  import ValidatedNumerics.Interval, ValidatedNumerics.@interval
   
  convert{R<:Real}(::Type{Rvl{ClCl}}, x::Interval{R}) = ClCl(x.lo,x.hi)
  convert{R<:Real}(::Type{Rvl}, x::Interval{R}) = convert(Rvl{ClCl}, x)
  function  convert{G<:Grasp,R<:Real}(::Type{Rvl{G,R}, x::Interval{R})
      lo, hi = grasp(G, x.lo, x.hi)
      Rvl{G,R}(lo, hi)
  end
  function  convert{G<:Grasp,R<:Real}(::Type{Interval{R}}, x::Rvl{G,R})
      lo, hi = release(G, x.lo, x.hi)
      @interval(lo, hi)
  end
  
end

