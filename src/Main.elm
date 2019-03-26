module Main exposing (main)

import Browser
import Dict exposing (Dict)
import Element exposing (Element)
import Element.Font
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


attendeesView attendees =
    List.map attendeeView attendees
        |> Element.column [ Element.spacing 20, Element.Font.size 16 ]


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


parsedAttendees =
    [ { first = "Dillon", last = Just "Kearns" }
    ]


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
