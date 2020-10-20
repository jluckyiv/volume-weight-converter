module FractionParser exposing (parse, parser)

import Fraction exposing (Fraction)
import Parser exposing (..)



-- Proper: numerator < denominator
-- Improper: numerator >= denominator
-- Mixed: whole number and a proper fraction


parse : String -> Result String Fraction
parse string =
    run parser string
        |> Result.mapError Parser.deadEndsToString
        |> Result.andThen Fraction.fromTuple


parser : Parser ( Int, Int )
parser =
    oneOf
        [ backtrackable mixedParser
        , backtrackable fractionParser
        , backtrackable wholeParser
        ]


mixedParser : Parser ( Int, Int )
mixedParser =
    succeed fromMixed
        |. spaces
        |= int
        |. spaces
        |= int
        |. spaces
        |. symbol "/"
        |. spaces
        |= int
        |. spaces


fractionParser : Parser ( Int, Int )
fractionParser =
    succeed fromFraction
        |. spaces
        |= int
        |. spaces
        |. symbol "/"
        |. spaces
        |= int
        |. spaces


wholeParser : Parser ( Int, Int )
wholeParser =
    succeed fromWhole
        |. spaces
        |= int
        |. spaces


fromWhole : Int -> ( Int, Int )
fromWhole numerator =
    Tuple.pair numerator 1


fromFraction : Int -> Int -> ( Int, Int )
fromFraction numerator denominator =
    Tuple.pair numerator denominator


fromMixed : Int -> Int -> Int -> ( Int, Int )
fromMixed whole numerator denominator =
    Tuple.pair (whole * denominator + numerator) denominator
