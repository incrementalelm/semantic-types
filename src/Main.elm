module Main exposing (main)

import Browser
import Dict exposing (Dict)
import Element exposing (Element)
import Html exposing (Html, button, div, h1, p, text)
import Html.Events exposing (onClick)
import Url


type Todo
    = Todo String


type alias Model =
    List Todo


type Msg
    = NoOp


init () =
    ( [], Cmd.none )


view : Model -> Browser.Document msg
view model =
    { title = "Your Event"
    , body = [ mainView model |> Element.layout [ Element.padding 30 ] ]
    }


mainView : Model -> Element msg
mainView model =
    Element.text "Attendees"
        |> Element.el [ Element.centerX ]


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \model -> Sub.none
        }
