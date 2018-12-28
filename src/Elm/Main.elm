module Main exposing (Model, Msg(..), main)

import Browser
import Browser.Events as Browser
import Element as UI exposing (Element, text)
import Element.Input as UI
import Html exposing (Html)
import Html.Attributes as Html
import Json.Decode as JD
import Model.Board as Board exposing (Board)
import Model.Entity as Entity exposing (Entity)
import Model.Note as Note exposing (Note)
import Model.Sticky as Sticky exposing (Sticky)
import Point exposing (Point)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type Msg
    = NoOp
    | Select (Maybe Entity)


type alias Model =
    Board


sticky : String -> Sticky
sticky str =
    { content = str
    , pos = Point 0 0
    , size = Point 100 100
    , isSelected = False
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Board
        []
        []
        Nothing
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        _ ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    UI.column
        []
        [ Board.view (Just >> Select) model ]
        |> UI.layout []


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.onMouseDown <| JD.succeed (Select Nothing)
