module Infra.Repositories.RunQuery
    ( runQuery'
    )
where

import           Database.Relational.Type       ( Query )
import           Database.Record                ( FromSql
                                                , ToSql
                                                )
import           Database.HDBC                  ( SqlValue )
import qualified Database.HDBC.Record          as Record
import           Control.Monad.IO.Class         ( liftIO )
import           Domain.Repositories.Repository ( Repository )
import           Control.Monad.Trans.Reader     ( ask )
import           Data.Pool                      ( withResource )

runQuery'
    :: (ToSql SqlValue p, FromSql SqlValue a)
    => Query p a
    -> p
    -> Repository [a]
runQuery' q p = do
    pool <- ask
    withResource pool $ \conn -> liftIO $ Record.runQuery' conn q p
