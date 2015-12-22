module ErrorFree

import Base:fma

export eftRecip, eftSquare, eftCube, 
       eftSqrt,  eftRecipSqrt, # see comment for eftSqrt
       eftSum2,  eftSum2inOrder, eftDiff2, eftDiff2inOrder, 
       eftProd2, eftDiv2,
       eftSum3,  eftSum3as2, eftSum3inOrder, eftSum3inOrderAs2,
       eftProd3, eftProd3as2,
       eftFMA,   eftFMS
       

@inline function eftSquare(a::Float64)
    x = a * a
    y = fma(a, a, -x)
    x,y
end

function eftCube(a::Float64)
    p = a*a; e = fma(a, a, -p)
    x = p*a; p = fma(p, a, -x)
    y = e*a
    x,y
end

# sassafrass! 'y' must be negated
#
@inline function eftRecip(a::Float64)
     x = one(Float64)/a
     y = -(fma(x,a,-1.0)/a)
     x,y
end

#=
   While not strictly an error-free transformation it is quite reliable and recommended for use.
   Augmented precision square roots, 2-D norms and discussion on correctly reounding sqrt(x^2 + y^2)
   by Nicolas Brisebarre, Mioara Joldes, Erik Martin-Dorel, Hean-Michel Muller, Peter Kornerup
=#
@inline function eftSqrt(a::Float64)
     x = sqrt(a)
     t = fma(x,-x,a)
     y = t / (x*2.0)
     x,y
end     
     
@inline function eftRecipSqrt(a::Float64)
     r = 1.0/a
     x = sqrt(r)
     t = fma(x,-x,r)
     y = t / (x*2.0)
     x,y
end


@inline function eftSum2{T<:Float64}(a::T, b::T)
  x = a + b
  t = x - a
  y = (a - (x - t)) + (b - t)
  x,y
end


@inline function eftSum2inOrder{T<:Float64}(a::T, b::T)
  x = a + b
  y = b - (x - a)
  x,y
end


@inline function eftDiff2{T<:Float64}(a::T, b::T)
  x = a - b
  t = x - a
  y = (a - (x - t)) - (b + t)
  x,y
end


@inline function eftDiff2inOrder{T<:Float64}(a::T, b::T)
  x = a - b
  y = (a - x) - b
  x,y
end

@inline function eftProd2{T<:Float64}(a::T, b::T)
    x = a * b
    y = fma(a, b, -x)
    x,y
end

# sassafrass!  'y' must be negated
#
@inline function eftDiv2{T<:Float64}(a::T,b::T)
     x = a/b
     y = -(fma(x,b,-a)/b)
     x,y
end

function eftSum3{T<:Float64}(a::T,b::T,c::T)
    s,t = eftSum2(b, c)
    x,u = eftSum2(a, s)
    y,z = eftSum2(u, t)
    x,y = eftSum2inOrder(x, y)
    x,y,z
end

function eftSum3inOrder{T<:Float64}(a::T,b::T,c::T)
    s,t = eftSum2inOrder(b, c)
    x,u = eftSum2inOrder(a, s)
    y,z = eftSum2inOrder(u, t)
    x,y = eftSum2inOrder(x, y)
    x,y,z
end

@inline function eftSum3as2{T<:Float64}(a::T,b::T,c::T)
    s,t = eftSum2(b, c)
    x,u = eftSum2(a, s)
    y = u+t
    x,y = eftSum2inOrder(x, y)
    x,y
end

@inline function eftSum3inOrderAs2{T<:Float64}(a::T,b::T,c::T)
    s,t = eftSum2inOrder(b, c)
    x,u = eftSum2inOrder(a, s)
    y = u+t
    x,y = eftSum2inOrder(x, y)
    x,y
end

function eftProd3{T<:Float64}(a::T, b::T, c::T)
    p,e = eftProd2(a,b)
    x,p = eftProd2(p,c)
    y,z = eftProd2(e,c)
    x,y,z
end

@inline function eftProd3as2{T<:Float64}(a::T, b::T, c::T)
    p,e = eftProd2(a,b)
    x,p = eftProd2(p,c)
    y = e*c
    x,y
end


end # module ErrorFree
