module Model.Board exposing (Board, view)

import Browser.Dom exposing (getElement)
import Element as UI exposing (Element)
import Html exposing (select)
import Model.Entity as Entity exposing (Entity, selectedView)
import Model.Note as Note exposing (..)
import Model.Sticky as Sticky exposing (..)


type alias Board =
    { notes : List Note
    , stickies : List Sticky
    , selected : Maybe Entity
    }


view : (Entity -> msg) -> Board -> Element msg
view msg board =
    UI.el
        ((board.notes
            |> List.map (Entity.noteView msg)
            |> List.map UI.inFront
         )
            ++ (board.stickies
                    |> List.map (Entity.stickyView msg)
                    |> List.map UI.inFront
               )
            ++ [ board.selected
                    |> Maybe.map selectedView
                    |> Maybe.withDefault UI.none
                    |> UI.inFront
               ]
        )
        UI.none
