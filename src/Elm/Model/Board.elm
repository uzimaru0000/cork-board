module Model.Board exposing (Board, childrenUpdate, view)

import Browser.Dom exposing (getElement)
import Element as UI exposing (Element)
import Html exposing (select)
import Model.Entity as Entity exposing (Entity, selectedView)
import Model.Note as Note exposing (..)
import Model.Sticky as Sticky exposing (..)


type alias Board =
    { children : List Entity
    , selected : Maybe Entity
    }


view : (Entity -> msg) -> Board -> Element msg
view msg board =
    UI.el
        ((board.children
            |> List.map (Entity.view msg)
            |> List.map UI.inFront
         )
            ++ [ board.selected
                    |> Maybe.map selectedView
                    |> Maybe.withDefault UI.none
                    |> UI.inFront
               ]
        )
        UI.none


childrenUpdate : Maybe Entity -> Board -> Board
childrenUpdate entity board =
    let
        ( children, selected ) =
            case ( entity, board.selected ) of
                ( Just e, Just s ) ->
                    ( s :: (board.children |> takeChild e)
                    , entity
                    )

                ( Just e, Nothing ) ->
                    ( board.children |> takeChild e
                    , entity
                    )

                ( Nothing, Just s ) ->
                    ( s :: board.children
                    , entity
                    )

                ( Nothing, Nothing ) ->
                    ( board.children
                    , entity
                    )
    in
    { board
        | children = children
        , selected = selected
    }


takeChild : Entity -> List Entity -> List Entity
takeChild entity list =
    case entity of
        Entity.Note n ->
            list
                |> List.filter ((/=) entity)

        Entity.Sticky s ->
            let
                parent =
                    getParent s list
            in
            case parent of
                Just p ->
                    (list
                        |> List.filter ((/=) <| Entity.Note p)
                    )
                        ++ [ Entity.Note { p | children = List.filter ((/=) s) p.children }
                           ]

                Nothing ->
                    list
                        |> List.filter ((/=) entity)


getParent : Sticky -> List Entity -> Maybe Note
getParent child list =
    list
        |> List.map
            (\x ->
                case x of
                    Entity.Note n ->
                        Just n

                    _ ->
                        Nothing
            )
        |> List.filter
            (\x ->
                case x of
                    Just y ->
                        y.children
                            |> List.any ((==) child)

                    Nothing ->
                        False
            )
        |> List.head
        |> Maybe.andThen identity
