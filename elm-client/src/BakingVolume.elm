module BakingVolume exposing
    ( BakingVolume
    , eggs
    , garlicHeads
    , usDryCups
    , usDryPints
    , usDryTablespoons
    , usDryTeaspoons
    )

import Volume exposing (Volume)


type BakingVolume
    = Volume Volume
    | GarlicHead Float
    | Egg Float


usDryPints : Float -> BakingVolume
usDryPints numUsDryPints =
    Volume (Volume.usDryPints numUsDryPints)


{-| Construct a volume from a number of U.S. dry cups.
-}
usDryCups : Float -> BakingVolume
usDryCups numUsDryCups =
    Volume (Volume.usDryPints (numUsDryCups / 2))


{-| Construct a volume from a number of U.S. dry tablespoons.
-}
usDryTablespoons : Float -> BakingVolume
usDryTablespoons numUsDryTablespoons =
    usDryCups (numUsDryTablespoons / 16)


{-| Construct a volume from a number of U.S. dry teaspoons.
-}
usDryTeaspoons : Float -> BakingVolume
usDryTeaspoons numUsDryTeaspoons =
    usDryTablespoons (numUsDryTeaspoons / 3)


garlicHeads : Float -> BakingVolume
garlicHeads numGarlicHeads =
    GarlicHead numGarlicHeads


eggs : Float -> BakingVolume
eggs numLargeEggs =
    Egg numLargeEggs
