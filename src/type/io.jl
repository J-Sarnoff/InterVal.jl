const PlusMinus  = "±"
const PosInfinity = "+∞"
const NegInfinity = "-∞"
const Empty      = "∅"
const Full       = "▣"
const Exactly    = "⌁"
const Inexactly  = "~"



# select characters corresponding to boundries as specified (lo,hi)
#   true for Open, false for Closed
#                          ClCl            ClOp            OpCl          OpOp

#const Delimiters = [ ( "⟨" , "⟩" ) , ( "⟨" , "⟫" ),  ( "⟪" , "⟩" ), ( "⟪" , "⟫" )  ];
#const Delimiters =  [ ( "⎰" , "⎱" ) , ( "⎰" , "⎰" ) ,  ( "⎱" , "⎱" ), ( "⎱" , "⎰" )  ];
const Delimiters =  [ ( "⟨" , "⟩" ) , ( "⟨" , "⦒" ) ,  ( "⦑" , "⟩" ), ( "⦑" , "⦒" )  ];

@inline delimiters(loIsOpen::Bool, hiIsOpen::Bool) =
      Delimiters[ one(Int8)+(reinterpret(Int8,loIsOpen)<<1)+hiIsOpen ]


function show{G<:Grasp,R<:Real}(io::IO, x::Rvl{G,R})
    tiestr = ", "
    Gstr = split(string(G),".")[2]
    s = if (x.lo != x.hi)
            string(Gstr,"(", x.lo, tiestr, x.hi, ")")
        elseif G==ClCl
            string(x.lo)
        else
            string(Gstr,"(", x.lo, ")")
        end    
    print(io, s)
end

#=
function show{G<:Grasp,R<:Real}(io::IO, x::Rvl{G,R})
    tiestr = ", "
    loDelim,hiDelim = delimiters(boundaries(G)...)
    s = if (x.lo != x.hi)
            string(loDelim, x.lo, tiestr, x.hi, hiDelim)
        elseif G==ClCl
            string(x.lo)
        else
            string(loDelim, x.lo, hiDelim)
        end    
    print(io, s)
end
=#

function showcompact{G<:Grasp,R<:Real}(io::IO, x::Rvl{G,R})
    tiestr = ", "
    Gstr = split(string(G),".")[2]
    lo = @sprintf("%7.5g", x.lo); lo = strip(lo)
    hi = @sprintf("%7.5g", x.hi); hi = strip(hi)
    s = if (x.lo != x.hi)
            string(Gstr,"(", lo, tiestr, hi, ")")
        elseif G==ClCl
            string(x.lo)
        else
            string(Gstr,"(", lo, ")")
        end    
    print(io, s)
end


function showmidrad{G<:Grasp,R<:Real}(io::IO, x::Rvl{G,R})
    md = @sprintf("%7.5g", mid(x)); md = strip(md)
    rd = @sprintf("%7.5g", rad(x)); rd = strip(rd)
    s = string(md, PlusMinus, rd)
    print(io, s)
end

showmidrad{G<:Grasp,R<:Real}(x::Rvl{G,R}) = showmidrad(STDOUT,x)

function showmidpointradius{G<:Grasp,R<:Real}(io::IO, x::Rvl{G,R})
    tiesym = (Q==INEXACT) ? Inexactly : Exactly
    md = mid(x)
    rd = rad(x)
    s  = string(md, PlusMinus, rd)
    print(io, s)
end

showmidpointradius{G<:Grasp,R<:Real}(x::Rvl{G,R}) = showmidpointradius(STDOUT,x)

