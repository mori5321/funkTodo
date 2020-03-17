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
import           Infra.Repositories.RunInsert   ( runInsert' )
import Queries.Todos.List (listTodos )


data TodoRepository = TodoRepository

instance TodoRepositoryClass TodoRepository where
    list TodoRepository = do
        todos' <-  runQuery' listTodos ()
        let todos = flip map todos' \todo -> makeTodo (Todos.id todo) (Todos.body todo)
        pure todos
    store TodoRepository _todo = do
        -- Transaction どこではるのがよい?
        runInsert' Todos.insertTodos todoDataModel
        pure ()
      where
        todoDataModel = Todos.Todos { Todos.id = 1, Todos.body = "HelloWorld", Todos.doneAt = Nothing }
