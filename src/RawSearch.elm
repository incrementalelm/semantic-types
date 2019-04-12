module RawSearch exposing (RawSearch, empty, encoded, input, unencoded)

import Element exposing (Element)
import Element.Input
import Url


type RawSearch
    = RawSearch String


empty : RawSearch
empty =
    RawSearch ""


unencoded : RawSearch -> String
unencoded (RawSearch rawSearch) =
    rawSearch


encoded : RawSearch -> String
encoded (RawSearch rawSearch) =
    Url.percentEncode rawSearch


input :
    List (Element.Attribute msg)
    -> Element.Input.Label msg
    -> RawSearch
    -> (RawSearch -> msg)
    -> Element msg
input attributes label (RawSearch currentValue) onInput =
    Element.Input.text attributes
        { onChange = \rawSearchInput -> rawSearchInput |> RawSearch |> onInput
        , text = currentValue
        , placeholder = Nothing
        , label = label
        }
