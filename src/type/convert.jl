for (fn) in (:ClCl, :ClOp, :OpCl, :OpOp)
    @eval ($fn){R1<:Real, R2<:Real}(a::R1, b::R2) = ($fn)(promote(a,b)...)
end

