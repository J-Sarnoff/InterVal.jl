module RoundFast

import Base:(+),(-),(*),(/),sqrt
export square

include("Adjacent.jl")
using .Adjacent

include("eftArith.jl")
include("eftRound.jl")
include("rounding.jl")

end # module
