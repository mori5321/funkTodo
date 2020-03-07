module Handlers.TodoHandler.List
    ( handler
    , API
    )
where

import           Servant.API
import           Domain.ValueObjects.Todo       ( Todo )
import           Infra.Repositories.TodoRepository
                                                ( TodoRepository(..)
                                                , list
                                                )
import           Handlers.Common                ( Handler
                                                , runRepository
                                                )

type API = Get '[JSON] [Todo]

handler :: Handler [Todo]
handler = do
    todos <- runRepository $ list TodoRepository
    pure todos
