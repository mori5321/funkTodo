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
import qualified Domain.ValueObjects.Todo      as Todo
import qualified Infra.DataModels.Todos        as Todos
import           Infra.DataModels.Todos         ( adapt
                                                , convert
                                                )
import           Infra.Repositories.RunQuery    ( runQuery' )
import           Infra.Repositories.RunInsert   ( runInsert' )
import           Database.HDBC.Record           ( runInsert )
import           Queries.Todos.List             ( listTodos )
import           Queries.Todos.FetchById        ( fetchTodoById )
import           Data.Pool                      ( withResource )
import           Database.HDBC                  ( commit )
import           Control.Monad.IO.Class         ( liftIO )
import           Domain.Repositories.Repository ( Repository )
import           Control.Monad.Trans.Reader     ( ask )


data TodoRepository = TodoRepository

instance TodoRepositoryClass TodoRepository where
    list TodoRepository = do
        todos' <- runQuery' listTodos ()
        let todos = map convert todos'
        pure todos
    fetchById TodoRepository id = do
        todos' <- runQuery' (fetchTodoById id) ()
        case todos' of
            [] -> pure Nothing
            xs -> pure $ Just $ convert $ head xs
    store TodoRepository todo = do
        todos' <- runQuery' (fetchTodoById todoID) ()
        case todos' of
            [] -> runInsert' Todos.insertTodos todoDataModel
            xs -> pure () -- TODO: Plz implement Update
      where
        todoDataModel                = adapt todo
        Todo.Mk { Todo.id = todoID } = todo
        --  
        -- pool <- ask
        -- liftIO $ withResource pool $ \conn -> do
        --    runInsert conn Todos.insertTodos todoDataModel
        --    commit conn
        --    pure ()
