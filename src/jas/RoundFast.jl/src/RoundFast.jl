module RoundFast

import Base:(+),(-),(*),(/),sqrt
export square

include("../../../module/Adjacent.jl/src/Adjacent.jl")
using .Adjacent

include("eftArith.jl")
include("eftRound.jl")
include("rounding.jl")

end # module
