module Attendee exposing (Attendee)

import Json.Decode as Decode exposing (Decoder)


type alias Attendee =
    { first : String
    , last : Maybe String
    }


decoder : Decoder (List Attendee)
decoder =
    Decode.fail "TODO"
