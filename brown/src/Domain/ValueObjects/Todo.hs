module Domain.ValueObjects.Todo
    ( Todo
    , makeTodo
    , TodoID
    )
where

import           GHC.Int                        ( Int32 )
import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )
import           GHC.Generics                   ( Generic )
import           Domain.ValueObjects.Todo.ID    ( ID(..) )
import           Domain.ValueObjects.Todo.Body  ( Body(..) )
import           Domain.ValueObjects.Todo.Done  ( Done(..) )

type TodoID = ID

data Todo = MkTodo { todoID :: ID
                 , body :: Body
                 -- , done :: Done
                 } deriving (Show, Generic, FromJSON, ToJSON)

makeTodo :: Int32 -> String -> Todo
makeTodo todoID body = MkTodo todoID' body'
  where
    todoID' = ID todoID
    body'   = Body body
    -- done'   = Done done
