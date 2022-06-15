module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Html exposing (Html)
import Html.Attributes as HA
import Json.Decode as Decode
import Timeline exposing (Event, Timeline)


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { timeline : Timeline
    }


type Msg
    = Noop


type alias Flags =
    { timeline : Decode.Value }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        model : Model
        model =
            { timeline = Timeline.decode flags.timeline
            }
    in
    ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        Noop ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    Html.div
        [ HA.class "timeline"
        ]
        [ Html.div [ HA.class "events" ] <|
            viewTerminator
                :: List.map viewRow model.timeline.events
                ++ [ viewTerminator ]
        ]


viewRow : Event -> Html msg
viewRow event =
    Html.div [ HA.class "row" ] <|
        viewLeftLeaf
            ++ [ viewEvent event ]


viewTerminator : Html msg
viewTerminator =
    Html.div [ HA.class "terminator" ]
        [ Html.div [ HA.class "trunk" ] []
        , Html.div [ HA.class "connection" ] []
        ]


viewEvent : Event -> Html msg
viewEvent event =
    Html.div [ HA.class "event" ] <|
        [ Html.h2 [ HA.class "title" ] [ Html.text event.title ] ]
            ++ (if String.isEmpty event.subtitle then
                    []

                else
                    [ Html.div [ HA.class "subtitle" ] [ Html.text event.subtitle ] ]
               )


viewLeftLeaf =
    [ Html.div [ HA.class "trunk" ] []
    , Html.div [ HA.class "connection" ] []
    , Html.div [ HA.class "stem" ] []
    ]
