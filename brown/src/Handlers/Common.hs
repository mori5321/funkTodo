{-# LANGUAGE FlexibleContexts #-}

module Handlers.Common
    ( runQuery'
    , Handler
    )
where

import           Control.Monad.IO.Class         ( liftIO )
import           Control.Monad.Trans.Class      ( lift )
import           Control.Monad.Trans.Reader     ( ask
                                                , ReaderT
                                                )
import           Data.Pool                      ( withResource
                                                , Pool
                                                )
import           Database.HDBC                  ( SqlValue )
import qualified Database.HDBC.Record          as R
import           Database.Record                ( FromSql
                                                , ToSql
                                                )
import           Database.Relational.Type       ( Query )
import           Database.HDBC.MySQL            ( Connection )
import qualified Servant                       as Servant

type Handler = ReaderT (Pool Connection) Servant.Handler

runQuery'
    :: (ToSql SqlValue p, FromSql SqlValue a) => Query p a -> p -> Handler [a]
runQuery' q p = do
    pool <- ask
    withResource pool $ \conn -> liftIO $ R.runQuery' conn q p
