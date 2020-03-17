module Handlers.TodoHandler.Create
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
import qualified UseCases.RegisterTodo         as RegisterTodo
import           Infra.Repositories.TodoRepository
                                                ( TodoRepository(..) )

type API = ReqBody '[JSON] Todo :> Post '[JSON] ()

-- Content-Type application/jsonを指定しないとマッチしないよ
-- curl http://localhost:8080/todos -X POST -d '{"id": 1, "body": "Hello World"}' -H "Content-Type: application/json"

handler :: Todo -> Handler ()
handler todo = do
    runUseCase $ RegisterTodo.execute repositories input
    pure ()
  where
    input        = RegisterTodo.Input { RegisterTodo.todo = todo }
    repositories = RegisterTodo.Repositories TodoRepository
