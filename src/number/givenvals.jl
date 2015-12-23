#  type-based valuations

zero{B<:BoundingDescriptor, R<:Real}(::Type{B},::Type{R}) = (B)(zero(R), zero(R))
 one{B<:BoundingDescriptor, R<:Real}(::Type{B},::Type{R}) = (B)( one(R),  one(R))

Inf{B<:BoundingDescriptor, R<:Real}(::Type{B},::Type{R}) = ((R)(Inf), (R)(Inf))
NaN{B<:BoundingDescriptor, R<:Real}(::Type{B},::Type{R}) = ((R)(NaN), (R)(NaN))




# predicates

iszero{B<:BoundingDescriptor, R<:Real}(a::Interval{B,R}) = a == zero(B,R)

