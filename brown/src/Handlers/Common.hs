{-# LANGUAGE FlexibleContexts #-}

module Handlers.Common
    ( runRepository
    , Handler
    )
where

import           Control.Monad.IO.Class         ( liftIO )
import           Control.Monad.Trans.Class      ( lift )
import           Control.Monad.Trans.Reader     ( ask
                                                , ReaderT
                                                , runReaderT
                                                )
import           Data.Pool                      ( Pool )
import           Database.HDBC.MySQL            ( Connection )
import qualified Servant

import           Domain.Repositories.Repository ( Repository )

type Handler = ReaderT (Pool Connection) Servant.Handler

runRepository :: Repository a -> Handler a
runRepository repo = do
    pool <- ask
    liftIO $ runReaderT repo pool
