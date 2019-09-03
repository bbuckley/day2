module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)


getAt : Int -> List a -> Maybe a
getAt idx xs =
    if idx < 0 then
        Nothing

    else
        List.head <| List.drop idx xs


curVal : Model -> Maybe Int
curVal model =
    getAt (modBy (List.length model.cycle) model.curIndex) model.cycle


type alias Model =
    { curIndex : Int, cycle : List Int }


init : ( Model, Cmd Msg )
init =
    ( { curIndex = 0, cycle = [ 4, 1, 2 ] }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | Cycle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Cycle ->
            ( { model | curIndex = modBy (List.length model.cycle) (model.curIndex + 1) }, Cmd.none )



---- VIEW ----


h1s : Int -> List (Html Msg)
h1s n =
    List.map (\_ -> h1 [] [ text "Your Elm App is working!" ]) (List.range 1 n)


view : Model -> Html Msg
view model =
    div []
        ([ img [ src "/logo.svg" ] []
         , h1 [] [ text "Your Elm App is working!" ]
         , button [ onClick Cycle ] [ "cycle" |> text ]
         ]
            ++ h1s (Maybe.withDefault 0 (getAt model.curIndex model.cycle))
        )



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
