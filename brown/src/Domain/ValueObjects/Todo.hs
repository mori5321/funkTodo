{-# LANGUAGE NoImplicitPrelude #-}

module Domain.ValueObjects.Todo
    ( Todo(..)
    , makeTodo
    , unwrapTodo
    , TodoID
    )
where

import           Prelude                 hiding ( id )
import           GHC.Int                        ( Int32 )
import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )
import           GHC.Generics                   ( Generic )
import           Domain.ValueObjects.Todo.ID    ( ID(..) )
import           Domain.ValueObjects.Todo.Body  ( Body(..) )
import           Domain.ValueObjects.Todo.Done  ( Done(..) )

type TodoID = ID

data Todo = Mk { id :: ID
               , body :: Body
               } deriving (Show, Generic, FromJSON, ToJSON)

makeTodo :: Int32 -> String -> Todo
makeTodo todoID body = Mk todoID' body'
  where
    todoID' = ID todoID
    body'   = Body body

-- DTO, DAOのためにスマートコンストラクタの逆をつくってみはしたが
-- これどうなんやろうか
-- ドメイン知識の流出なんやろか
-- ドメイン知識の流出ってそもそもなんやろか
unwrapTodo :: Todo -> (Int32, String)
unwrapTodo todo = (id', body')
  where
    ID   id'   = id todo
    Body body' = body todo
