module Example exposing (suite)

import Attendee
import Expect exposing (Expectation)
import Json.Decode
import Test exposing (..)


suite =
    describe "attendee decoder"
        [ test "parses an empty list" <|
            \() ->
                "[]"
                    |> decodesTo []
        , test "single attendee" <|
            \() ->
                """[{"first": "James", "last": "Kirk"}]"""
                    |> decodesTo [ { first = "James", last = Just "Kirk" } ]
        , test "a different attendee" <|
            \() ->
                """[{"first": "Jill", "last": "Kirk"}]"""
                    |> decodesTo [ { first = "Jill", last = Just "Kirk" } ]
        , test "attendee with null last name" <|
            \() ->
                """[{"first": "Spock", "last": null}]"""
                    |> decodesTo [ { first = "Spock", last = Nothing } ]
        ]


decodesTo : List Attendee.Attendee -> String -> Expectation
decodesTo expected jsonString =
    jsonString
        |> Json.Decode.decodeString Attendee.decoder
        |> Result.mapError Json.Decode.errorToString
        |> Expect.equal (Ok expected)
