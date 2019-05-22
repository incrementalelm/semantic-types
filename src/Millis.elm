module Millis exposing (Millis(..), distance, millis, toDays, toTimer)


type Millis
    = Millis Int


distance : Millis -> Millis -> Millis
distance (Millis millis1) (Millis millis2) =
    millis (millis1 - millis2)


millis : Int -> Millis
millis n =
    Millis n


millisPerSecond =
    1000


secondsPerMinute =
    60


minutesPerHour =
    60


hoursPerDay =
    24


toTimer : Millis -> { days : Int, hours : Int, seconds : Int }
toTimer ms =
    { days = toDays ms, hours = 0, seconds = toSeconds ms }


toDays : Millis -> Int
toDays (Millis ms) =
    (toFloat ms
        / (millisPerSecond
            * secondsPerMinute
            * minutesPerHour
            * hoursPerDay
           -- * 81.4
          )
    )
        |> round


toSeconds : Millis -> Int
toSeconds (Millis ms) =
    ms
        |> modBy
            (millisPerSecond
             -- * secondsPerMinute
             -- * minutesPerHour
             -- * hoursPerDay
             -- * 81.4
            )



-- |> round
