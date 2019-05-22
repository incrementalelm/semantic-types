module Social exposing (main)

import Browser
import Duration
import Element exposing (Element)
import Element.Font
import Element.Input
import Millis exposing (Millis(..), millis)
import Time


type alias Flags =
    ()


type alias Model =
    { ssnInput : String }


type Msg
    = NoOp


init : () -> ( Model, Cmd msg )
init () =
    ( { ssnInput = "" }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Semantic Types Demo"
    , body = [ mainView model |> Element.layout [ Element.padding 30 ] ]
    }


mainView : Model -> Element Msg
mainView model =
    Element.column
        [ Element.spacing 30, Element.centerX, Element.width Element.fill ]
        []


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
