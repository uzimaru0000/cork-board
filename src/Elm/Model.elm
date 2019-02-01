module Model exposing (Model, Movement, Msg(..), init)

import Model.Entity exposing (..)
import Point exposing (..)
import Reference exposing (Reference)


type alias Model =
    { entities : List Entity
    , ref : Maybe (Reference Entity (List Entity))
    }


type Msg
    = NoOp
    | Select (Reference Entity (List Entity))
    | Drag Point
    | End


type alias Movement =
    { ref : Reference Entity (List Entity)
    , pos : Point
    , parent : Point
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        [ Entity
            { pos = Point 100 100, size = Point 300 300 }
            (Note
                [ Entity
                    { pos = Point 20 20, size = Point 100 100 }
                    (Sticky "child")
                , Entity
                    { pos = Point 50 20, size = Point 100 100 }
                    (Sticky "child")
                ]
            )
        ]
        Nothing
    , Cmd.none
    )
