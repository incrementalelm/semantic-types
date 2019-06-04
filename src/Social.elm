port module Social exposing (main)

import Browser
import Element exposing (Element)
import Element.Border
import Element.Events
import Element.Font
import Element.Input
import FocusState exposing (FocusState(..))
import Http
import Json.Decode
import RemoteData exposing (WebData)
import Url.Builder


type alias Model =
    { ssnInput : String
    , ssnFocus : FocusState
    , serverResponse : WebData (Maybe String)
    }


type Msg
    = ChangedSsnInput String
    | SsnFocusChanged FocusState
    | SubmitSsn
    | GotSavedSsn (Result Http.Error (Maybe String))
    | GotSubmitResponse (WebData (Maybe String))


port showSsnSubmitStatus : String -> Cmd msg


init : () -> ( Model, Cmd Msg )
init () =
    ( { ssnInput = ""
      , ssnFocus = OutOfFocus
      , serverResponse = RemoteData.NotAsked
      }
    , Http.get
        { url = Url.Builder.relative [ "api" ] []
        , expect = Http.expectJson GotSavedSsn (Json.Decode.maybe Json.Decode.string)
        }
    )


view : Model -> Browser.Document Msg
view model =
    { title = "Semantic Types Demo"
    , body = [ mainView model |> Element.layout [ Element.padding 30 ] ]
    }


mainView : Model -> Element Msg
mainView model =
    Element.column
        [ Element.spacing 30, Element.centerX, Element.width Element.fill ]
        [ ssnInput model
        , Element.el
            [ Element.Border.width 2
            , Element.padding 10
            , Element.pointer
            , Element.Events.onClick SubmitSsn
            ]
            (Element.text "Submit")
        , serverResponseView model.serverResponse
        ]


serverResponseView : WebData (Maybe String) -> Element msg
serverResponseView errorHttpResult =
    case errorHttpResult of
        RemoteData.Success Nothing ->
            Element.text "✅"

        RemoteData.Success (Just error) ->
            Element.text ("\u{1F6D1} " ++ error)

        RemoteData.Failure errorHttp ->
            Element.text (Debug.toString errorHttp)

        RemoteData.NotAsked ->
            Element.text ""

        RemoteData.Loading ->
            Element.text "..."


ssnInput : Model -> Element Msg
ssnInput model =
    Element.Input.text
        [ Element.Events.onFocus (SsnFocusChanged InFocus)
        , Element.Events.onLoseFocus (SsnFocusChanged OutOfFocus)
        ]
        { onChange = ChangedSsnInput
        , text =
            case model.ssnFocus of
                InFocus ->
                    model.ssnInput

                OutOfFocus ->
                    model.ssnInput |> maskedSsn
        , placeholder = Nothing
        , label = Element.Input.labelAbove [] (Element.text "SSN")
        }


maskedSsn : String -> String
maskedSsn ssn =
    ssn
        |> String.replace "0" "X"
        |> String.replace "1" "X"
        |> String.replace "2" "X"
        |> String.replace "3" "X"
        |> String.replace "4" "X"
        |> String.replace "5" "X"
        |> String.replace "6" "X"
        |> String.replace "7" "X"
        |> String.replace "8" "X"
        |> String.replace "9" "X"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangedSsnInput changedSsn ->
            ( { model | ssnInput = changedSsn }, Cmd.none )

        SsnFocusChanged focusState ->
            ( { model | ssnFocus = focusState }, Cmd.none )

        SubmitSsn ->
            ( model, submitSsnWithStatus model.ssnInput )

        GotSubmitResponse response ->
            ( { model | serverResponse = response }, Cmd.none )

        GotSavedSsn savedSsnResult ->
            case savedSsnResult of
                Ok (Just savedSsn) ->
                    ( { model | ssnInput = savedSsn }, Cmd.none )

                unexpected ->
                    ( model, Cmd.none )


submitSsnWithStatus : String -> Cmd Msg
submitSsnWithStatus ssn =
    Cmd.batch
        [ showSsnSubmitStatus ssn
        , sendSsnToServer ssn
        ]


sendSsnToServer : String -> Cmd Msg
sendSsnToServer ssn =
    Http.get
        { url =
            Url.Builder.relative
                [ "api" ]
                [ Url.Builder.string "ssn" ssn
                ]
        , expect =
            Http.expectJson
                (\result ->
                    result
                        |> RemoteData.fromResult
                        |> GotSubmitResponse
                )
                (Json.Decode.field "error" (Json.Decode.maybe Json.Decode.string))
        }



-- Elm Architecture setup


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
