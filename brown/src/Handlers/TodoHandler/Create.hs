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

type API = ReqBody '[JSON] Todo :> Post '[JSON] Todo

-- Content-Type application/jsonを指定しないとマッチしないよ
-- curl http://localhost:8080/todos -X POST -d '{"id": 1, "body": "Hello World"}' -H "Content-Type: application/json"

handler :: Todo -> Handler Todo
handler todo = pure newtodo where newtodo = makeTodo 1 "Hello"
