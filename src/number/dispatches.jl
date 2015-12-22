#  type-based valuations

zero{B<:BoundingDescriptor, R<:Real}(::Type{B},::Type{R}) = (B)(zero(R), zero(R))
one{B<:BoundingDescriptor, R<:Real}(::Type{B},::Type{R}) = (one(R),one(R))

Inf{B<:BoundingDescriptor, R<:Real}(::Type{B},::Type{R}) = (one(R),one(R))
NaN{B<:BoundingDescriptor, R<:Real}(::Type{B},::Type{R}) = (one(R),one(R))





