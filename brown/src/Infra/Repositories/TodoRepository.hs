module Infra.Repositories.TodoRepository
    ( TodoRepository(..)
    , list
    )
where


import           Domain.Repositories.TodoRepositoryClass
                                                ( TodoRepositoryClass(..) )
import           Domain.ValueObjects.Todo       ( Todo(..)
                                                , TodoID
                                                , makeTodo
                                                )
import qualified Infra.DataModels.Todos        as Todos
import           Infra.Repositories.RunQuery    ( runQuery' )
import Queries.Todos.List (listTodos )


data TodoRepository = TodoRepository

instance TodoRepositoryClass TodoRepository where
    list TodoRepository = do
            todos' <-  runQuery' listTodos ()
            let todos = flip map todos' \todo -> makeTodo (Todos.id todo) (Todos.body todo)
            pure todos
