module TemperatureConverter exposing (main)

import Browser
import Dict exposing (Dict)
import Element exposing (Element)
import Element.Font
import Element.Input
import Html exposing (Html, button, div, h1, p, text)
import Html.Events exposing (onClick)
import Json.Decode


type alias Flags =
    ()


type alias Model =
    { temperature : String }


type Msg
    = NoOp
    | OnInput String


init : () -> ( Model, Cmd msg )
init () =
    ( { temperature = "" }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Escaper/Unescaper"
    , body = [ mainView model |> Element.layout [ Element.padding 30 ] ]
    }


mainView : Model -> Element Msg
mainView model =
    Element.column
        [ Element.spacing 30, Element.centerX, Element.width Element.fill ]
        [ temperatureInputView model.temperature
        , temperatureInputViewF model.temperature
        ]


temperatureInputView temperature =
    Element.Input.text []
        { onChange = OnInput
        , text = temperature
        , placeholder = Nothing
        , label = Element.Input.labelAbove [] (Element.text "Degrees C")
        }


cToF celsius =
    celsius * (9 / 5) + 32


temperatureInputViewF temperatureC =
    Element.Input.text []
        { onChange = OnInput
        , text =
            temperatureC
                |> String.toFloat
                |> Maybe.map cToF
                |> Maybe.map String.fromFloat
                |> Maybe.withDefault ""
        , placeholder = Nothing
        , label = Element.Input.labelAbove [] (Element.text "Degrees F")
        }


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnInput newInput ->
            ( { model | temperature = newInput }, Cmd.none )
