
module Infra.Repositories.RunUpdate
    ( runUpdate'
    )
where

import           Database.Relational.Type       ( Query
                                                , Update
                                                )
import           Database.Record                ( FromSql
                                                , ToSql
                                                )
import           Database.HDBC                  ( SqlValue )
import qualified Database.HDBC.Record          as Record
import           Control.Monad.IO.Class         ( liftIO )
import           Domain.Repositories.Repository ( Repository )
import           Control.Monad.Trans.Reader     ( ask )
import           Data.Pool                      ( withResource
                                                , takeResource
                                                )
import           Database.HDBC                  ( commit )


runUpdate' :: (ToSql SqlValue a) => Update a -> a -> Repository ()
runUpdate' update value = do
    pool <- ask
    withResource pool $ \conn -> do
        liftIO $ Record.runUpdate conn update value
        liftIO $ commit conn -- ここにトランザクションの単位があることはよいことなのだろうか?
