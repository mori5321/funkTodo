module Queries.Todos.List
    ( listTodos
    )
where

import           Database.Relational.Type       ( Query )
import qualified Database.Relational           as R
import           Database.Relational.Relation   ( relation )

import qualified Infra.DataModels.Todos        as Todos
                                                ( Todos(..)
                                                , todos
                                                )

listTodos :: Query () Todos.Todos
listTodos = R.relationalQuery (relation $ R.query Todos.todos)
