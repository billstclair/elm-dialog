module Main exposing (main)

import Browser
import Dialog
import Html exposing (Html, button, div, node, text)
import Html.Attributes exposing (class, style, type_)
import Html.Events exposing (onClick)


main =
    Browser.element
        { init = \() -> init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { myDialogVisible : Dialog.Visible }


type Msg
    = ToggleMyDialogVisible


init : ( Model, Cmd Msg )
init =
    ( { myDialogVisible = Dialog.hidden }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleMyDialogVisible ->
            ( { model | myDialogVisible = not model.myDialogVisible }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    div [ style "padding" "48px" ]
        [ Dialog.render
            { styles = [ ( "width", "40%" ) ]
            , title = "My Dialog"
            , content = [ text "This is my dialog's body." ]
            , actionBar = [ dialogButton "Close" ]
            }
            model.myDialogVisible
        , dialogButton "Show Dialog"
        ]
        |> loadMdlHack


dialogButton : String -> Html Msg
dialogButton caption =
    button
        [ onClick ToggleMyDialogVisible
        , class "mdl-button mdl-button--raised mdl-button--accent"
        ]
        [ text caption ]



-- This loads mdl styles inline and is for demonstration purposes in elm reactor only
-- Thanks debois and pdamoc


loadMdlHack : Html Msg -> Html Msg
loadMdlHack content =
    div []
        [ node "style"
            [ type_ "text/css" ]
            [ text "@import url(https://code.getmdl.io/1.3.0/material.indigo-pink.min.css);" ]
        , content
        ]
