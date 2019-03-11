module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, p, text)
import Html.Events exposing (onClick)
import Url
import Url.Parser exposing ((</>))


type alias Model =
    Maybe String


type Msg
    = OnUrlRequest Browser.UrlRequest
    | OnUrlChange Url.Url


init () url navigationKey =
    ( parseUrl url, Cmd.none )


parseUrl : Url.Url -> Maybe String
parseUrl url =
    url
        |> Url.Parser.parse (Url.Parser.s "article" </> Url.Parser.string)


type alias Article =
    { title : String
    , body : String
    }


view : Maybe String -> Browser.Document msg
view maybeArticlePath =
    articleNotFoundDocument


articleDocument : Article -> Browser.Document msg
articleDocument article =
    { title = article.title
    , body =
        [ h1 [] [ text <| "Article - " ++ article.title ]
        , p [] [ text article.body ]
        ]
    }


articleNotFoundDocument : Browser.Document msg
articleNotFoundDocument =
    { title = "Article Not Found"
    , body = [ text "Article not found..." ]
    }


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \model -> Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }
