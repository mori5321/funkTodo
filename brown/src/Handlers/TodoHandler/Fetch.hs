module Handlers.TodoHandler.Fetch
    ( handler
    , API
    )
where

import           Servant.API
import           Servant.Server                 ( err404
                                                , errBody
                                                )
import           Control.Monad.Except           ( throwError )
import           GHC.Int                        ( Int32 )
import           Domain.ValueObjects.Todo       ( Todo
                                                , makeTodo
                                                )
import           Domain.ValueObjects.Todo.ID    ( ID(..) )
import           Handlers.Common                ( Handler
                                                , runUseCase
                                                )
import qualified UseCases.FetchTodoById        as FetchTodoById
import           UseCases.FetchTodoById         ( mTodo
                                                , todoID
                                                )
import           Infra.Repositories.TodoRepository
                                                ( TodoRepository(..) )

type API = Capture "id" Int32 :> Get '[JSON] Todo

handler :: Int32 -> Handler Todo
handler id = do
    let input        = FetchTodoById.Input { todoID = todoID }
    let repositories = FetchTodoById.Repositories TodoRepository

    FetchTodoById.Output { mTodo } <- runUseCase
        $ FetchTodoById.execute repositories input

    case mTodo of
        Just todo -> pure todo
        Nothing   -> throwError $ err404 { errBody = "Oops..." }
    where todoID = ID id
