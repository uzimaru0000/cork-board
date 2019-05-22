module Model.Entity exposing (Content(..), Entity(..), Transform, getParent, getContent, move)

import Point exposing (Point)
import Reference


type Entity
    = Entity Transform Content


type Content
    = Note (List Entity)
    | Sticky String


type alias Transform =
    { pos : Point
    , size : Point
    }


move : Point -> Entity -> Entity
move movement (Entity ({ pos } as transform) content) =
    Entity { transform | pos = Point.add pos movement } content


getContent : Entity -> Content
getContent (Entity _ content) =
    content


getParent : List Entity -> Entity -> Maybe Entity
getParent entities child =
    let
        -- 受け取ったEntityがchildの親かどうか判定
        helper entity =
            case getContent entity of
                Note list ->
                    List.member child list

                Sticky _ ->
                    False
    in
    case entities of
        head :: tail ->
            if helper head then
                Just head

            else
                getParent tail child

        [] ->
            Nothing


outOfParent : Entity -> Entity -> Bool
outOfParent (Entity transform _) (Entity { pos, size } _) =
    [ pos.x < -size.x
    , pos.y < -size.y
    , pos.x > transform.size.x
    , pos.y > transform.size.y
    ]
        |> List.any identity
