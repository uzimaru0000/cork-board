module Example exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Model.Entity as Entity exposing (..)
import Point exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "get parent"
        [ test "1st case" <|
            \_ ->
                let
                    entities =
                        [ Entity
                            { pos = Point 100 100, size = Point 300 300 }
                            (Note
                                [ Entity
                                    { pos = Point 20 20, size = Point 100 100 }
                                    (Sticky "child")
                                , Entity
                                    { pos = Point 50 20, size = Point 100 100 }
                                    (Sticky "child")
                                ]
                            )
                        ]

                    child =
                        Entity
                            { pos = Point 20 20, size = Point 100 100 }
                            (Sticky "child")
                in
                Expect.equal
                    (Entity.getParent entities child)
                    (Just <|
                        Entity
                            { pos = Point 100 100, size = Point 300 300 }
                            (Note
                                [ Entity
                                    { pos = Point 20 20, size = Point 100 100 }
                                    (Sticky "child")
                                , Entity
                                    { pos = Point 50 20, size = Point 100 100 }
                                    (Sticky "child")
                                ]
                            )
                    )
        , test "Nothing" <|
            \_ ->
                let
                    entities =
                        [ Entity
                            { pos = Point 100 100, size = Point 300 300 }
                            (Note
                                [ Entity
                                    { pos = Point 20 20, size = Point 100 100 }
                                    (Sticky "child")
                                , Entity
                                    { pos = Point 50 20, size = Point 100 100 }
                                    (Sticky "child")
                                ]
                            )
                        ]

                    child =
                        Entity
                            { pos = Point 20 20, size = Point 50 100 }
                            (Sticky "child")
                in
                Expect.equal
                    (Entity.getParent entities child)
                    Nothing
        ]
