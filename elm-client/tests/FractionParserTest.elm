module FractionParserTest exposing (..)

import Expect
import Fraction exposing (Fraction)
import FractionParser exposing (..)
import Test exposing (..)


all : Test
all =
    describe "FractionParser"
        [ describe "Whole numbers"
            [ test "Parse 2" <|
                \_ ->
                    Expect.equal (parse "2" |> Result.map Fraction.toTuple) (Ok ( 2, 1 ))
            ]
        , describe "Fractions"
            [ test "Parse 2/3" <|
                \_ ->
                    Expect.equal (parse "2/3" |> Result.map Fraction.toTuple) (Ok ( 2, 3 ))
            ]
        , describe "Mixed fractions"
            [ test "Parse 2 2/3" <|
                \_ ->
                    Expect.equal (parse "2 2/3" |> Result.map Fraction.toTuple) (Ok ( 8, 3 ))
            ]
        ]
