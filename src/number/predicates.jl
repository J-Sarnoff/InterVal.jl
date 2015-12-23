
@inline iszero{T<:Real}(x::T) = (x == zero(T))
@inline isone{T<:Real}(x::T) = (x == one(T))

@inline function isfinite{T<:Rvl}(ivl::T)
    isfinite(ivl.lo) & isfinite(ivl.hi)
end    
@inline function issubnormal{T<:Rvl}(ivl::T)
    issubnormal(ivl.lo) | issubnormal(ivl.hi)
end    
@inline function isnormal{T<:Rvl}(ivl::T)
    isfinite(ivl) & !issubnormal(ivl)
end    
@inline function isinf{T<:Rvl}(ivl::T)
    isinf(ivl.lo) | isinf(ivl.hi)
end    
@inline function isnan{T<:Rvl}(ivl::T)
    isnan(ivl.lo) | isnan(ivl.hi)
end    

@inline function isPoint{T<:Rvl}(ivl::T)
    (ivl.lo == ivl.hi) && isfinite(ivl.lo)
end    
@inline function isNotPoint{T<:Rvl}(ivl::T)
    (ivl.lo != ivl.hi) || !isfinite(ivl.lo)
end    
@inline function isBoundry{T<:Rvl}(ivl::T)
    (ivl.lo != ivl.hi) && isnan(ivl)
end    
@inline function isNotBoundry{T<:Rvl}(ivl::T)
    (ivl.lo == ivl.hi) || !isnan(ivl)
end    
@inline function isExact{T<:Rvl}(ivl::T)
    (isExact(ivl.lo) & isExact(ivl.hi)) && (isfinite(ivl.lo) & isfinite(ivl.hi))
end    
@inline function isNotExact{T<:Rvl}(ivl::T)
    (isNotExact(ivl.lo) | isNotExact(ivl.hi)) || (!isfinite(ivl.lo) | !isfinite(ivl.hi))
end    

@inline function isExactPoint{T<:Rvl}(ivl::T)
    isPoint(ivl) && isExact(ivl)
end
@inline function isNotExactPoint{T<:Rvl}(ivl::T)
    isNotPoint(ivl) || isNotExact(ivl)
end
@inline function isInexactPoint{T<:Rvl}(ivl::T)
    isPoint(ivl) && isNotExact(ivl)
end
@inline function isNotInexactPoint{T<:Rvl}(ivl::T)
    isNotPoint(ivl) || isExact(ivl)
end

@inline function isExactBoundry{T<:Rvl}(ivl::T)
    isBoundry(ivl) && isExact(ivl)
end
@inline function isNotExactBoundry{T<:Rvl}(ivl::T)
    isNotBoundry(ivl) || isNotExact(ivl)
end
@inline function isInexactBoundry{T<:Rvl}(ivl::T)
    isBoundry(ivl) && isNotExact(ivl)
end
@inline function isNotInexactBoundry{T<:Rvl}(ivl::T)
    isNotBoundry(ivl) || isExact(ivl)
end

@inline function isClosedOpen{T<:Rvl}(ivl::T)
    isExact(ivl.lo) & isInexact(ivl.hi)
end    
@inline function isOpenClosed{T<:Rvl}(ivl::T)
    isInexact(ivl.lo) & isExact(ivl.hi)
end    
@inline function isOpenOpen{T<:Rvl}(ivl::T)
    isInexact(ivl.lo) & isInexact(ivl.hi)
end    
@inline function isClosedClosed{T<:Rvl}(ivl::T)
    isExact(ivl.lo) & isExact(ivl.hi)
end    



