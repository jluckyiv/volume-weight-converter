module Fraction exposing (Fraction, create, fromTuple, toFloat, toTuple)


type Fraction
    = Fraction Pieces


type alias Pieces =
    { numerator : Int
    , denominator : Int
    }


create : Int -> Int -> Result String Fraction
create numerator denominator =
    if denominator == 0 then
        Err "Divide by zero"

    else
        Ok (Fraction (Pieces numerator denominator))


fromTuple : ( Int, Int ) -> Result String Fraction
fromTuple ( numerator, denominator ) =
    create numerator denominator


toTuple : Fraction -> ( Int, Int )
toTuple (Fraction pieces) =
    ( pieces.numerator, pieces.denominator )


toFloat : Fraction -> Float
toFloat (Fraction pieces) =
    Basics.toFloat pieces.numerator / Basics.toFloat pieces.denominator
