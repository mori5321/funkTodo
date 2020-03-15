module Handlers.TodoHandler.List
    ( handler
    , API
    )
where

import           Servant.API
import           Domain.ValueObjects.Todo       ( Todo
                                                , makeTodo
                                                )
import           Handlers.Common                ( Handler
                                                , runUseCase
                                                )
import qualified UseCases.FetchTodoList        as FetchTodoList
import           UseCases.FetchTodoList         ( todos )
import           Infra.Repositories.TodoRepository
                                                ( TodoRepository(..) )

type API = Get '[JSON] [Todo]

handler :: Handler [Todo]
handler = do
    let input        = FetchTodoList.Input
    let repositories = FetchTodoList.Repositories TodoRepository
    FetchTodoList.Output { todos = todos } <- runUseCase
        $ FetchTodoList.execute repositories input
    pure todos
