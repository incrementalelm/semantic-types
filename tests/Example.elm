module Example exposing (suite)

import Expect exposing (Expectation)
import Json.Decode
import Tennis
import Test exposing (..)


suite =
    describe "tennis"
        [ test "new game" <|
            \() ->
                Tennis.new
                    |> Tennis.scoreString
                    |> Expect.equal "Love-Love"
        , test "player 1 scores" <|
            \() ->
                Tennis.new
                    |> Tennis.player1Scores
                    |> Tennis.scoreString
                    |> Expect.equal "15-Love"
        ]
