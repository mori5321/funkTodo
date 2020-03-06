module Handlers.TodoHandler
    ( TodosAPI
    , handler
    , listTodos
    )
where

import           Prelude                 hiding ( id )
import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )
import           GHC.Generics                   ( Generic )
import qualified Network.Wai.Handler.Warp      as Warp
import           Data.Proxy                     ( Proxy(..) )
import           Servant.API
import           Servant.Server                 ( Server )

import qualified Infra.DataModels.Todos              as Todos
import           Infra.DataModels.Todos               ( Todos(..) )
import           Domain.ValueObjects.Todo             ( Todo
                                                , makeTodo
                                                )
import           Handlers.Common                ( Handler
                                                , runQuery'
                                                )
import qualified Database.Relational           as R
import           Database.Relational            ( (><) )
import           Database.Relational.Relation   ( relation )
import           GHC.Int                        ( Int32 )

type TodosAPI = Get '[JSON] [Todo]
      -- :<|> "todo" :> Capture "todoID" TodoID :> Get '[JSON] Todo


-- todosHandler :: Handler [Todo]
-- todosHandler = listTodos where listTodos = pure todosList

listTodos :: R.Relation () Todos
listTodos = relation $ R.query Todos.todos
    -- flip map todos \todo -> (makeTodo (id todo) (body todo))

handler :: Handler [Todo]
handler = do
    results <- runQuery' (R.relationalQuery listTodos) ()
    let todos = flip map results $ \todo -> makeTodo (id todo) (body todo)
    pure todos


