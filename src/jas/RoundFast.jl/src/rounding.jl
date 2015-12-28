
function (+){T<:AbstractFloat, R<:RoundingMode}(a::T, b::T, rounding::R)
    hi,lo = eftSum2(a,b)
    eftRound(hi, lo, rounding)
end

function (-){T<:AbstractFloat, R<:RoundingMode}(a::T, b::T, rounding::R)
    hi,lo = eftDiff2(a,b)
    eftRound(hi, lo, rounding)
end

function (*){T<:AbstractFloat, R<:RoundingMode}(a::T, b::T, rounding::R)
    hi,lo = eftProd2(a,b)
    eftRound(hi, lo, rounding)
end

function (/){T<:AbstractFloat, R<:RoundingMode}(a::T, b::T, rounding::R)
    hi,lo = eftDiv2Approx(a,b)
    eftRound(hi, lo, rounding)
end

function (square){T<:AbstractFloat, R<:RoundingMode}(a::T, rounding::R)
    hi,lo = eftSquare(a)
    eftRound(hi, lo, rounding)
end

function (sqrt){T<:AbstractFloat, R<:RoundingMode}(a::T, rounding::R)
    hi,lo = eftSqrtApprox(a)
    eftRound(hi, lo, rounding)
end

for op in (:(+), :(-), :(*), :(/))
    @eval ($op){T<:Integer, R<:RoundingMode}(a::Rational{T}, b::Rational{T}, rounding::R) = ($op)(a,b)
end

if isdefined(Main,:FloatFloat)
FF=Main.FloatFloat.FF
for op in (:(+), :(-), :(*), :(/))
    @eval begin
        function ($op){T<:FF, R<:RoundingMode}(a::T, b::T, rounding::R)
            c = zero(T)
            with_rounding(Float64,rounding) do
                c = ($op)(a, b)
            end
            c
        end
    end
end
end
function (+){T<:Real, R<:RoundingMode}(a::T, b::T, rounding::R)
    c = zero(T)
    with_rounding(T,R) do
        c = a + b
    end
    c
end

function (-){T<:Real, R<:RoundingMode}(a::T, b::T, rounding::R)
    c = zero(T)
    with_rounding(T,R) do
        c = a - b
    end
    c
end

function (*){T<:Real, R<:RoundingMode}(a::T, b::T, rounding::R)
    c = zero(T)
    with_rounding(T,R) do
        c = a * b
    end
    c
end

function (/){T<:Real, R<:RoundingMode}(a::T, b::T, rounding::R)
    c = zero(T)
    with_rounding(T,R) do
        c = a / b
    end
    c
end

function (square){T<:Real, R<:RoundingMode}(a::T, rounding::R)
    c = zero(T)
    with_rounding(T,R) do
        c = a*a
    end
    c
end

function (sqrt){T<:Real, R<:RoundingMode}(a::T, rounding::R)
    c = zero(T)
    with_rounding(T,R) do
        c = sqrt(a)
    end
    c
end
