module Handlers.TodoHandler
    ( TodosAPI
    , todosHandler
    )
where

import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )
import           GHC.Generics                   ( Generic )
import qualified Network.Wai.Handler.Warp      as Warp
import           Data.Proxy                     ( Proxy(..) )
import           Servant.API
import           Servant.Server                 ( Server )

import           DomainObjects.Todo             ( Todo
                                                , makeTodo
                                                )

type TodosAPI = Get '[JSON] [Todo]
      -- :<|> "todo" :> Capture "todoID" TodoID :> Get '[JSON] Todo


todosList :: [Todo]
todosList =
    [ makeTodo "1" "Check Calendar"       False
    , makeTodo "2" "Write Haskell 1 Line" False
    , makeTodo "3" "Cook Dinner"          False
    ]

todosHandler :: Server TodosAPI
todosHandler = listTodos where listTodos = pure todosList
