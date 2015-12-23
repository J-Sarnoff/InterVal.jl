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


end # module
