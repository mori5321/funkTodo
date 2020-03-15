module Handlers.TodoHandler
    ( API
    , handler
    )
where

import           Prelude                 hiding ( id )
import           Servant.API
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

type API = List.API
      -- :<|> "todo" :> Capture "todoID" TodoID :> Get '[JSON] Todo


handler :: Handler [Todo]
handler = List.handler
