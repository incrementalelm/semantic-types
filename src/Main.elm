module Main exposing (main)

import Attendee
import Browser
import Dict exposing (Dict)
import Element exposing (Element)
import Element.Font
import Html exposing (Html, button, div, h1, p, text)
import Html.Events exposing (onClick)
import Json.Decode
import Url


type Todo
    = Todo String


type alias Model =
    ()


type Msg
    = NoOp


init : () -> ( (), Cmd msg )
init () =
    ( (), Cmd.none )


view : Model -> Browser.Document msg
view model =
    { title = "Your Event"
    , body = [ mainView model |> Element.layout [ Element.padding 30 ] ]
    }


attendeesView :
    Result Json.Decode.Error (List { a | first : String, last : Maybe String })
    -> Element msg
attendeesView attendeesResult =
    case attendeesResult of
        Ok attendees ->
            List.map attendeeView attendees
                |> Element.column [ Element.spacing 20, Element.Font.size 16 ]

        Err error ->
            error
                |> Json.Decode.errorToString
                |> Element.text
                |> Element.el []


attendeeView : { a | first : String, last : Maybe String } -> Element msg
attendeeView attendee =
    Element.row []
        [ (case attendee.last of
            Just last ->
                attendee.first ++ " " ++ last

            Nothing ->
                attendee.first
          )
            |> Element.text
        ]


parsedAttendees : Result error (List { first : String, last : Maybe String })
parsedAttendees =
    Ok [ { first = "Dillon", last = Just "Kearns" } ]


attendeesJson : String
attendeesJson =
    """
  [
    {"first": "James", "last": "Kirk"},
    {"first": "Leonard", "last": "McCoy"},
    {"first": "Spock"},
    {"first": "Nyota", "last": "Uhura"}
  ]
  """


mainView : Model -> Element msg
mainView model =
    Element.column
        [ Element.spacing 30, Element.centerX ]
        [ Element.text "Attendees"
            |> Element.el []
        , attendeesView parsedAttendees
        ]


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \model -> Sub.none
        }
