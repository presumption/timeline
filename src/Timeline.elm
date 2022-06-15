module Timeline exposing (..)

import Json.Decode as Decode exposing (Decoder)


type alias Timeline =
    { events : List Event }


type alias Event =
    { title : String
    , subtitle : String
    , time : String
    }


decode : Decode.Value -> Timeline
decode events =
    case Decode.decodeValue timelineDecoder events of
        Ok value ->
            value

        Err error ->
            { events = [] }


timelineDecoder : Decoder Timeline
timelineDecoder =
    Decode.map Timeline
        (Decode.field "events" (Decode.list eventDecoder))


eventDecoder : Decoder Event
eventDecoder =
    Decode.map3 Event
        (Decode.field "title" Decode.string)
        (Decode.field "subtitle" Decode.string)
        (Decode.field "time" Decode.string)
