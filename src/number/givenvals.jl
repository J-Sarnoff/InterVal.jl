#  type-based valuations

zero{B<:Reach, R<:Real}(::Type{B},::Type{R}) = (B)(zero(R), zero(R))
 one{B<:Reach, R<:Real}(::Type{B},::Type{R}) = (B)( one(R),  one(R))

 Inf{B<:Reach, R<:Real}(::Type{B},::Type{R}) = ((R)(Inf), (R)(Inf))
 NaN{B<:Reach, R<:Real}(::Type{B},::Type{R}) = ((R)(NaN), (R)(NaN))




# predicates

iszero{B<:Reach, R<:Real}(a::Interval{B,R}) = (a == zero(B,R))

