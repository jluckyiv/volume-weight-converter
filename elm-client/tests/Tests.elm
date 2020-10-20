module Tests exposing (..)

import BakingVolume as Volume
import Expect
import Fraction
import FractionParser
import Json.Decode as Decode
import Test exposing (..)
import TestData exposing (..)
import VolumeParser exposing (..)
import WeightChart exposing (..)



-- Check out https://package.elm-lang.org/packages/elm-explorations/test/latest to learn more about testing in Elm!


all : Test
all =
    describe "All"
        [ describe "Volumes"
            [ test "A dry pint is 2 dry cups" <|
                \_ ->
                    Expect.equal (Volume.usDryPints 1) (Volume.usDryCups 2)
            , test "A dry cup is 16 dry tablespoons" <|
                \_ ->
                    Expect.equal (Volume.usDryCups 1) (Volume.usDryTablespoons 16)
            , test "A dry tablespoon is three dry teaspoons" <|
                \_ ->
                    Expect.equal (Volume.usDryTablespoons 1) (Volume.usDryTeaspoons 3)
            ]
        , describe "Parsers"
            [ describe "Fraction parser"
                [ test "It parses a proper fraction" <|
                    \_ ->
                        Expect.equal (Fraction.create 1 2) (FractionParser.parse "1/2")
                ]
            , describe "Volumetric parser"
                [ test "It parses a single cup" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "1 cup") (Ok (Volume.usDryCups 1))
                , test "It parses a single tablespoon" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "1 tablespoon") (Ok (Volume.usDryTablespoons 1))
                , test "It parses a single teaspoon" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "1 teaspoon") (Ok (Volume.usDryTeaspoons 1))
                , test "It parses a single garlic head" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "1 large head") (Ok (Volume.garlicHeads 1))
                , test "It parses a single egg" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "1 large") (Ok (Volume.eggs 1))
                , test "It parses multiple cups" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "2 cups") (Ok (Volume.usDryCups 2))
                , test "It parses multiple tablespoons" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "2 tablespoons") (Ok (Volume.usDryTablespoons 2))
                , test "It parses multiple teaspoons" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "2 teaspoons") (Ok (Volume.usDryTeaspoons 2))
                , test "It parses multiple garlic heads" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "2 large heads") (Ok (Volume.garlicHeads 2))
                , test "It parses multiple eggs" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "2 large") (Ok (Volume.eggs 2))
                , test "It parses fractional cups" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "1/2 cup") (Ok (Volume.usDryCups 0.5))
                , test "It parses fractional tablespoons" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "1/2 tablespoons") (Ok (Volume.usDryTablespoons 0.5))
                , test "It parses fractional teaspoons" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "1/4 teaspoons") (Ok (Volume.usDryTeaspoons 0.25))
                , test "It parses mixed fractional cups" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "4 1/2 cups") (Ok (Volume.usDryCups 4.5))
                , test "It parses mixed fractional tablespoons" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "2 1/4 tablespoons") (Ok (Volume.usDryTablespoons 2.25))
                , test "It parses mixed fractional teaspoons" <|
                    \_ ->
                        Expect.equal (VolumeParser.parse "1 1/2 teaspoons") (Ok (Volume.usDryTeaspoons 1.5))
                ]
            , describe "JSON Parser"
                [ test "It parses a simple volume-to-weight value" <|
                    \_ ->
                        let
                            expected =
                                Ok
                                    { ingredient = "Barley flour"
                                    , volume = "1 cup"
                                    , ounces = "3"
                                    , grams = "85"
                                    }

                            actual =
                                Decode.decodeString WeightChart.decoder barleyFlour
                        in
                        Expect.equal expected actual
                ]
            ]
        ]
