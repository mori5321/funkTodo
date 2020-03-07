module Handlers.TodoHandler
    ( TodosAPI
    , handler
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

import qualified Infra.DataModels.Todos        as Todos
import           Infra.DataModels.Todos         ( Todos(..) )
import           Domain.ValueObjects.Todo       ( Todo
                                                , makeTodo
                                                )
import           Handlers.Common                ( Handler
                                                , runQuery'
                                                )
import qualified Database.Relational           as R
import           Database.Relational            ( (><) )
import           Database.Relational.Relation   ( relation )
import           GHC.Int                        ( Int32 )

import           Infra.Repositories.TodoRepository
                                                ( TodoRepository(..)
                                                , list
                                                )
import           Control.Monad.Trans.Class      ( lift )
import           Control.Monad.IO.Class         ( liftIO )
import           Control.Monad.Trans.Reader     ( ask
                                                , runReaderT
                                                , ReaderT
                                                )
import qualified Servant.Server                as Servant
import           Domain.Repositories.Repository ( Repository )

type TodosAPI = Get '[JSON] [Todo]
      -- :<|> "todo" :> Capture "todoID" TodoID :> Get '[JSON] Todo

runRepository :: Repository a -> Handler a
runRepository reader = do
    pool <- ask
    liftIO $ runReaderT reader pool

handler :: Handler [Todo]
handler = do
    todos <- runRepository $ list TodoRepository
    pure todos
