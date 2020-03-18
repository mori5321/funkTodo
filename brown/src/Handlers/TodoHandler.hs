module Handlers.TodoHandler
    ( API
    , handler
    )
where

import           Prelude                 hiding ( id )
import           Servant.API
import           Servant                        ( Server
                                                , Proxy(..)
                                                , hoistServer
                                                , serve
                                                )
import qualified Servant
import           Domain.ValueObjects.Todo       ( Todo )
import           Handlers.Common                ( Handler )
import           Infra.Repositories.TodoRepository
                                                ( TodoRepository(..)
                                                , list
                                                )
import           Control.Monad.IO.Class         ( liftIO )
import           Control.Monad.Trans.Reader     ( ask
                                                , runReaderT
                                                )
import           Domain.Repositories.Repository ( Repository )

import qualified Handlers.TodoHandler.List     as List
                                                ( API
                                                , handler
                                                )
import qualified Handlers.TodoHandler.Create   as Create
                                                ( API
                                                , handler
                                                )
import qualified Handlers.TodoHandler.Fetch    as Fetch
                                                ( API
                                                , handler
                                                )

type API = List.API :<|> Create.API :<|> Fetch.API
      -- :<|> "todo" :> Capture "todoID" TodoID :> Get '[JSON] Todo

handler = List.handler :<|> Create.handler :<|> Fetch.handler
