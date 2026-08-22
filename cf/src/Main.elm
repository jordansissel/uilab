module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

-- MAIN
main : Program () Model Msg
main = 
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL
type alias Model =
  { clicker : Int,
    showing: Showing
  }

type Showing
  = None
    | Greeting

init : Model
init =
  Model 0 None

-- UPDATE
type Msg
  = Clicker
  | Show Showing

update : Msg -> Model -> Model
update msg model =
  case msg of
    Clicker ->
      { model | clicker = model.clicker + 1 }
    Show showing ->
      { model | showing = showing }

-- VIEW
--

view : Model -> Html Msg
view model =
  div [ class "terminal scanlines dirty phosphor" ] [
    case model.showing of
      None -> warning "WARNING" "OMG"
      Greeting -> dialog [] "Hello, world!" [(text "You're next!")]
    , div [class "buttons"] [
        button [ class "up yellow", onClick Clicker ] [text "OK"]
        ,button [ class "up blue" ] [text (String.fromInt(model.clicker))]
        ,button [ class "up", onClick (Show Greeting) ] [text "OK"]
      ]
  ]

warning : String -> String -> Html msg
warning title body =
  dialog [class "red"] title [(text body)]

dialog : List (Html.Attribute msg) -> String -> List (Html msg) -> Html msg
dialog attributes title content =
  section (List.append attributes [ class "dialog" ]) [
    header [ class "title" ] [ text title ]
    , div [ class "content" ] content
  ]

