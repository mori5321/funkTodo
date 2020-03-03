module DomainObjects.Todo
    ( Todo
    , makeTodo
    )
where


import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )
import           GHC.Generics                   ( Generic )
import           DomainObjects.Todo.ID          ( ID(..) )
import           DomainObjects.Todo.Title       ( Title(..) )
import           DomainObjects.Todo.Done        ( Done(..) )

data Todo = MkTodo { todoID :: ID
                 , title :: Title
                 , done :: Done
                 } deriving (Show, Generic, FromJSON, ToJSON)

makeTodo :: String -> String -> Bool -> Todo
makeTodo todoID title done = MkTodo todoID' title' done'
  where
    todoID' = ID todoID
    title'  = Title title
    done'   = Done done
