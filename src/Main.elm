module Main exposing (main)

import Browser
import Html exposing (Html, pre, text)
import Http


type MyCmd
    = MyHttp (Result Http.Error String -> Msg) String


myCmdToCmd : MyCmd -> Cmd Msg
myCmdToCmd myCmd =
    case myCmd of
        MyHttp toMsg url ->
            Http.get
                { url = url
                , expect = Http.expectString toMsg
                }


main : Program () Model Msg
main =
    Browser.element
        { init = \flags -> flags |> init |> Tuple.mapSecond myCmdToCmd
        , update = update
        , subscriptions = \model -> Sub.none
        , view = view
        }


type Model
    = Failure
    | Loading
    | Success String


init : () -> ( Model, MyCmd )
init _ =
    ( Loading
    , MyHttp GotText "https://elm-lang.org/assets/public-opinion.txt"
    )


type Msg
    = GotText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            text "I was unable to load your book."

        Loading ->
            text "Loading..."

        Success fullText ->
            pre [] [ text fullText ]
