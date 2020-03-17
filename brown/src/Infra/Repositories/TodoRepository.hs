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
import           Infra.DataModels.Todos         ( adapt
                                                , convert
                                                )
import           Infra.Repositories.RunQuery    ( runQuery' )
import           Infra.Repositories.RunInsert   ( runInsert' )
import           Database.HDBC.Record           ( runInsert )
import           Queries.Todos.List             ( listTodos )
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
    store TodoRepository todo = runInsert' Todos.insertTodos todoDataModel
        where todoDataModel = adapt todo
        --  
        -- pool <- ask
        -- liftIO $ withResource pool $ \conn -> do
        --    runInsert conn Todos.insertTodos todoDataModel
        --    commit conn
        --    pure ()
