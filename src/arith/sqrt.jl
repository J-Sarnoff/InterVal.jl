for T in (:ClCl, :ClOp, :OpCl, :OpOp)
   @eval begin
       function (sqrt){R<:Real}(a::Rvl{$T,R})
           lo = (sqrt)(a.lo, RoundDown)
           hi = (sqrt)(a.hi, RoundUp)
           Rvl{$T,R}(lo,hi)
       end
   end       
end
