module Queries.Todos.FetchById
    ( fetchTodoById
    )
where

import           Database.Relational.Type       ( Query )
import qualified Database.Relational           as R
import           Database.Relational            ( (.=.)
                                                , value
                                                , (!)
                                                , wheres
                                                , query
                                                )
import           Database.Relational.Relation   ( relation )
import qualified Infra.DataModels.Todos        as Todos
import           Infra.DataModels.Todos
import           Domain.ValueObjects.Todo       ( TodoID )
import           Domain.ValueObjects.Todo.ID    ( ID(..) )
import           Language.SQL.Keyword.Type      ( Keyword(LIMIT)
                                                , word
                                                )

fetchTodoById :: TodoID -> Query () Todos.Todos
fetchTodoById todoID = R.relationalQuery'
    (relation $ do
        t <- query Todos.todos
        wheres $ t ! id' .=. value todoID'
        return t
    )
    [LIMIT, word $ show 1]
    where ID todoID' = todoID
