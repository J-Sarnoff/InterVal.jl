#  type-based valuations

zero{G<:Grasp, R<:Real}(::Type{G},::Type{R}) = (G)(zero(R), zero(R))
 one{G<:Grasp, R<:Real}(::Type{G},::Type{R}) = (G)( one(R),  one(R))

# Inf{G<:Grasp, R<:Real}(::Type{G},::Type{R}) = (G)((R)(Inf), (R)(Inf))
# NaN{G<:Grasp, R<:Real}(::Type{G},::Type{R}) = (G)((R)(NaN), (R)(NaN))


