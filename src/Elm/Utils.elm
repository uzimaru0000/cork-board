module Utils exposing (preventDefaultOn, stopPropagationOn)

import Html exposing (Attribute)
import Html.Events as Html
import Json.Decode as JD


stopPropagationOn : String -> msg -> Bool -> Attribute msg
stopPropagationOn name msg flag =
    JD.succeed ( msg, flag )
        |> Html.stopPropagationOn name


preventDefaultOn : String -> msg -> Bool -> Attribute msg
preventDefaultOn name msg flag =
    JD.succeed ( msg, flag )
        |> Html.preventDefaultOn name
