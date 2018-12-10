module Model.Sticky exposing (Sticky)

import Element as UI exposing (Element)
import Element.Background as UI
import Element.Events as UI
import Html exposing (..)
import Point exposing (..)


type alias Sticky =
    { content : String
    , pos : Point
    , size : Point
    , isSelected : Bool
    }
