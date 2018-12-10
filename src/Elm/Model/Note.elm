module Model.Note exposing (Note)

import Element as UI exposing (Element)
import Element.Background as UI
import Element.Events as UI
import Html exposing (..)
import Model.Sticky as Sticky exposing (Sticky)
import Point exposing (Point)


type alias Note =
    { children : List Sticky
    , pos : Point
    , size : Point
    , isSelected : Bool
    }
