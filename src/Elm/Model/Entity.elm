module Model.Entity exposing (Entity(..), selectedView, view)

import Element as UI exposing (Element)
import Element.Background as UI
import Element.Border as Border
import Element.Events as UI
import Json.Decode as JD
import Model.Note exposing (Note)
import Model.Sticky exposing (Sticky)
import Point exposing (..)
import Svg.Attributes exposing (enableBackground)
import Utils


type Entity
    = Note Note
    | Sticky Sticky


view : (Entity -> msg) -> Entity -> Element msg
view msg entity =
    case entity of
        Note record ->
            noteView msg record

        Sticky record ->
            stickyView msg record


stickyView : (Entity -> msg) -> Sticky -> Element msg
stickyView msg data =
    UI.text data.content
        |> UI.el
            [ data.size.x |> UI.px |> UI.width
            , data.size.y |> UI.px |> UI.height
            , data.pos.x |> toFloat |> UI.moveRight
            , data.pos.y |> toFloat |> UI.moveDown
            , UI.color <| UI.rgb 0 1 0
            , Utils.stopPropagationOn "mousedown" (msg <| Sticky data) True
                |> UI.htmlAttribute
            ]


noteView : (Entity -> msg) -> Note -> Element msg
noteView msg data =
    UI.el
        ((data.children
            |> List.map (stickyView msg)
            |> List.map UI.inFront
         )
            ++ [ data.size.x |> UI.px |> UI.width
               , data.size.y |> UI.px |> UI.height
               , data.pos.x |> toFloat |> UI.moveRight
               , data.pos.y |> toFloat |> UI.moveDown
               , UI.color <| UI.rgb 1 0 0
               , Utils.stopPropagationOn "mousedown" (msg <| Note data) True
                    |> UI.htmlAttribute
               ]
        )
        UI.none


selectedView : Entity -> Element msg
selectedView entity =
    case entity of
        Note { size, pos } ->
            UI.el
                [ size.x |> UI.px |> UI.width
                , size.y |> UI.px |> UI.height
                , pos.x |> toFloat |> UI.moveRight
                , pos.y |> toFloat |> UI.moveDown
                , Border.color <| UI.rgb 0 0 0
                , Border.width 5
                ]
                UI.none

        Sticky { size, pos } ->
            UI.el
                [ size.x |> UI.px |> UI.width
                , size.y |> UI.px |> UI.height
                , pos.x |> toFloat |> UI.moveRight
                , pos.y |> toFloat |> UI.moveDown
                , Border.color <| UI.rgb 0 0 0
                , Border.width 5
                ]
                UI.none
