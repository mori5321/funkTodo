module Infra.Repositories.TodoRepository
    ( TodoRepository(..)
    , list
    )
where

import           Database.Relational.Type       ( Query )
import qualified Database.Relational           as R
import           Database.Relational.Relation   ( relation )

import           Domain.Repositories.TodoRepositoryClass
                                                ( TodoRepositoryClass(..) )
import           Domain.ValueObjects.Todo       ( Todo(..)
                                                , TodoID
                                                , makeTodo
                                                )
import qualified Infra.DataModels.Todos        as Todos
import           Infra.Repositories.RunQuery    ( runQuery' )

listTodos :: Query () Todos.Todos
listTodos = R.relationalQuery (relation $ R.query Todos.todos)

data TodoRepository = TodoRepository

instance TodoRepositoryClass TodoRepository where
    list TodoRepository = do
            todos' <-  runQuery' listTodos ()
            let todos = flip map todos' \todo -> makeTodo (Todos.id todo) (Todos.body todo)
            pure todos
