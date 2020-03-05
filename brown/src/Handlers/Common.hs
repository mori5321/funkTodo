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
import           Database.HDBC.Record          as R
import           Database.HDBC.MySQL            ( Connection )
import qualified Servant

type Handler = (ReaderT (Pool Connection) Servant.Handler)
