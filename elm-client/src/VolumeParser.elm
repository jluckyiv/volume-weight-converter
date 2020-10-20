module VolumeParser exposing (ParsedVolume(..), Unit(..), parse)

import BakingVolume exposing (..)
import Fraction exposing (Fraction)
import FractionParser
import Parser exposing (..)


type ParsedVolume
    = ParsedVolume Quantity Unit


type alias Quantity =
    Float


type Unit
    = Cup
    | Tablespoon
    | Teaspoon
    | Egg
    | GarlicHead


parse : String -> Result String BakingVolume
parse string =
    string
        |> String.trim
        |> run parser
        |> Result.mapError deadEndsToString
        |> Result.andThen toBakingVolume


parser : Parser ParsedVolume
parser =
    succeed fromFractional
        |= FractionParser.parser
        |. spaces
        |= unitParser


fromFractional : ( Int, Int ) -> Unit -> ParsedVolume
fromFractional ( numerator, denominator ) unit =
    let
        volume =
            Fraction.create numerator denominator
                |> Result.map Fraction.toFloat
                |> Result.withDefault 0
    in
    ParsedVolume volume unit


toBakingVolume : ParsedVolume -> Result String BakingVolume
toBakingVolume parsedVolume =
    case parsedVolume of
        ParsedVolume quantity Cup ->
            Ok (usDryCups quantity)

        ParsedVolume quantity Tablespoon ->
            Ok (usDryTablespoons quantity)

        ParsedVolume quantity Teaspoon ->
            Ok (usDryTeaspoons quantity)

        ParsedVolume quantity GarlicHead ->
            Ok (garlicHeads quantity)

        ParsedVolume quantity Egg ->
            Ok (eggs quantity)


unitParser : Parser Unit
unitParser =
    oneOf
        [ succeed Cup |. symbol "cup"
        , succeed Tablespoon |. symbol "tablespoon"
        , succeed Teaspoon |. symbol "teaspoon"
        , succeed GarlicHead |. symbol "large head"
        , succeed Egg |. symbol "large"
        ]
