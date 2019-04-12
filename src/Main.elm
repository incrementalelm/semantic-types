module Main exposing (main)

import Browser
import Dict exposing (Dict)
import Element exposing (Element)
import Element.Font
import Html exposing (Html, button, div, h1, p, text)
import Html.Events exposing (onClick)
import Json.Decode
import Url


type alias Flags =
    ()


type alias Model =
    ()


type Msg
    = NoOp


init : () -> ( (), Cmd msg )
init () =
    ( (), Cmd.none )


view : Model -> Browser.Document msg
view model =
    { title = "Escaper/Unescaper"
    , body = [ mainView model |> Element.layout [ Element.padding 30 ] ]
    }


mainView : Model -> Element msg
mainView model =
    Element.column
        [ Element.spacing 30, Element.centerX ]
        [ Element.text "Attendees"
            |> Element.el []
        ]


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \model -> Sub.none
        }
