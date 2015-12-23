(==){G<:Grasp, R<:Real}(a::Interval{G,R}, b::Interval{G,R}) = ((a.lo == b.lo) & (a.hi == b.hi))
(!=){G<:Grasp, R<:Real}(a::Interval{G,R}, b::Interval{G,R}) = ((a.lo != b.lo) | (a.hi != b.hi))
(<=){G<:Grasp, R<:Real}(a::Interval{G,R}, b::Interval{G,R}) = ((a.lo <= b.lo) & (a.hi <= b.hi))
(>=){G<:Grasp, R<:Real}(a::Interval{G,R}, b::Interval{G,R}) = ((a.lo >= b.lo) & (a.hi >= b.hi))
(< ){G<:Grasp, R<:Real}(a::Interval{G,R}, b::Interval{G,R}) = (!(a >= b))
(> ){G<:Grasp, R<:Real}(a::Interval{G,R}, b::Interval{G,R}) = (!(a <= b))

(isequal){G<:Grasp, R<:Real}(a::Interval{G,R}, b::Interval{G,R}) = (a == b)
(isless ){G<:Grasp, R<:Real}(a::Interval{G,R}, b::Interval{G,R}) = (a <  b)

