
module Infra.Repositories.RunInsert
    ( runInsert'
    )
where

import           Database.Relational.Type       ( Query
                                                , Insert
                                                )
import           Database.Record                ( FromSql
                                                , ToSql
                                                )
import           Database.HDBC                  ( SqlValue )
import qualified Database.HDBC.Record          as Record
import           Control.Monad.IO.Class         ( liftIO )
import           Domain.Repositories.Repository ( Repository )
import           Control.Monad.Trans.Reader     ( ask )
import           Data.Pool                      ( withResource )

runInsert' :: (ToSql SqlValue a) => Insert a -> a -> Repository Integer
runInsert' insertion value = do
    pool <- ask
    withResource pool $ \conn -> liftIO $ Record.runInsert conn insertion value
