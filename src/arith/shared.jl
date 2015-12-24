for op in (:(+),:(-),:(*),:(/))
  @eval begin
     function ($op){G1<:Grasp,G2<:Grasp,R1<:Real,R2<:Real}(a::Rvl{G1,R1}, b::Rvl{G2,R2})
         R = promote_type(R1,R2)
         alo,blo = promote(a.lo,b.lo)
         ahi,bhi = promote(a.hi,b.hi)
         ($op)(Rvl{G1,R}(alo,ahi), Rvl{G2,R}(blo,bhi))
     end
  end
end
  

