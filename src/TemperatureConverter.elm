module TemperatureConverter exposing (main)

import Browser
import Dict exposing (Dict)
import Element exposing (Element)
import Element.Font
import Element.Input
import Html exposing (Html, button, div, h1, p, text)
import Html.Events exposing (onClick)
import Json.Decode
import RawSearch exposing (RawSearch)


type alias Flags =
    ()


type alias Model =
    { inputValue : RawSearch }


type Msg
    = NoOp
    | OnInput RawSearch


init : () -> ( Model, Cmd msg )
init () =
    ( { inputValue = RawSearch.empty }, Cmd.none )


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
            { url = googleLink model.inputValue
            , label =
                Element.text
                    ("Search Google for \""
                        ++ RawSearch.unencoded model.inputValue
                        ++ "\""
                    )
            }
        ]


googleLink : RawSearch -> String
googleLink inputValue =
    "https://google.com/search?q=" ++ RawSearch.encoded inputValue


toEncode : RawSearch -> Element Msg
toEncode inputValue =
    RawSearch.input [ Element.width Element.fill ]
        (Element.Input.labelAbove [] (Element.text "Raw text (Not Encoded)"))
        inputValue
        OnInput


toDecode : RawSearch -> Element Msg
toDecode rawValue =
    Element.Input.text [ Element.width Element.fill ]
        { onChange = \_ -> NoOp
        , text = RawSearch.encoded rawValue
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


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnInput newInput ->
            ( { model | inputValue = newInput }, Cmd.none )
