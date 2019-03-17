module Main exposing (main)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, button, div, h1, p, text)
import Html.Events exposing (onClick)
import Url
import Url.Parser exposing ((</>))


type Todo
    = Todo String


type alias Model =
    List Todo


type Msg
    = OnUrlRequest Browser.UrlRequest
    | OnUrlChange Url.Url


init () url navigationKey =
    ( [], Cmd.none )


view : Model -> Browser.Document msg
view model =
    { title = "Todo"
    , body = []
    }


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \model -> Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }
