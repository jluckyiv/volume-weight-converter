module WeightChart exposing (decoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Decode


type alias Entry =
    { ingredient : String, volume : String, ounces : String, grams : String }


decoder : Decoder Entry
decoder =
    Decode.succeed Entry
        |> Decode.required "ingredient" Decode.string
        |> Decode.required "volume" Decode.string
        |> Decode.required "ounces" Decode.string
        |> Decode.required "grams" Decode.string
