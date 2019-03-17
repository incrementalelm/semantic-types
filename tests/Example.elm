module Example exposing (suite)

import Expect exposing (Expectation)
import Test exposing (..)


empty =
    []


suite : Test
suite =
    describe "todos"
        [ test "empty" <|
            \() ->
                empty
                    |> Expect.equal []
        ]
