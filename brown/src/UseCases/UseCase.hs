{-# LANGUAGE ExistentialQuantification #-}

module UseCases.UseCase where

import           Data.Pool                      ( Pool )
import           Database.HDBC.MySQL            ( Connection )
import           Domain.Repositories.Repository ( Repository )
import           Control.Monad.IO.Class         ( liftIO )
import           Control.Monad.Trans.Reader     ( ask
                                                , ReaderT
                                                , runReaderT
                                                )
import           Control.Monad                  ( liftM )
import           Control.Monad.IO.Class         ( liftIO )
import           Control.Monad.Trans.Class      ( lift )


type UseCase a = Repository a

runRepository :: Repository a -> UseCase a
runRepository repo = do
    pool <- ask
    liftIO $ runReaderT repo pool
