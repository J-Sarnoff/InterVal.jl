module InterVal

import Base: convert, promote_type, show, showcompact,
    read, write, string, hash, sizeof,
    issubnormal, isfinite, isreal, isinf, isnan,
    zero, one, Inf, NaN,
    (==),(!=),(<),(<=),(>=),(>), isless, isequal,
    (+),(-),(*),(/)

export ClCl, ClOp, OpCl, OpOp,
       lowerbound, upperbound



include("jas/ErrorFree.jl/src/ErrorFree.jl")
using .ErrorFree
include("jas/Adjacent.jl/src/Adjacent.jl")
using .Adjacent
include("jas/RoundFast.jl/src/RoundFast.jl")
using .RoundFast

include("type/interval.jl")
include("type/easily.jl")
include("type/bounding.jl")

include("number/compares.jl")
include("number/givenvals.jl")
include("number/predicates.jl")

include("arith/add.jl")
include("arith/sub.jl")
include("arith/mul.jl")
include("arith/div.jl")
include("arith/shared.jl")





end # module
