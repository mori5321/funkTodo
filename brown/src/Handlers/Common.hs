{-# LANGUAGE FlexibleContexts #-}

module Handlers.Common
    ( runUseCase
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

import           UseCases.UseCase               ( UseCase )
import           Domain.Repositories.Repository ( Repository
                                                , ConnectionPoolReaderT
                                                )

type Handler a = ConnectionPoolReaderT Servant.Handler a

runUseCase :: UseCase a -> Handler a
runUseCase usecase = do
    pool <- ask
    liftIO $ runReaderT usecase pool

