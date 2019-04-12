module Main exposing (main)

import Browser
import Dict exposing (Dict)
import Element exposing (Element)
import Element.Font
import Element.Input
import Html exposing (Html, button, div, h1, p, text)
import Html.Events exposing (onClick)
import Json.Decode
import Url


type alias Flags =
    ()


type alias Model =
    { inputValue : String }


type Msg
    = NoOp
    | OnInput String


init : () -> ( Model, Cmd msg )
init () =
    ( { inputValue = "" }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Escaper/Unescaper"
    , body = [ mainView model |> Element.layout [ Element.padding 30 ] ]
    }


mainView : Model -> Element Msg
mainView model =
    Element.column
        [ Element.spacing 30, Element.centerX, Element.width Element.fill ]
        [ toEncode model.inputValue
        , toDecode model.inputValue
        , Element.newTabLink []
            { url = googleLink (Url.percentEncode model.inputValue)
            , label = Element.text ("Search Google for \"" ++ model.inputValue ++ "\"")
            }
        ]


googleLink : String -> String
googleLink inputValue =
    "https://google.com/" ++ Url.percentEncode inputValue


toEncode inputValue =
    Element.Input.text [ Element.width Element.fill ]
        { onChange = OnInput
        , text = inputValue
        , placeholder = Nothing
        , label = Element.Input.labelAbove [] (Element.text "Raw text (Not Encoded)")
        }


toDecode rawValue =
    Element.Input.text [ Element.width Element.fill ]
        { onChange = \_ -> NoOp
        , text = Url.percentEncode rawValue
        , placeholder = Nothing
        , label = Element.Input.labelAbove [] (Element.text "Valid URL (Encoded)")
        }


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }


update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnInput newInput ->
            ( { model | inputValue = newInput }, Cmd.none )
