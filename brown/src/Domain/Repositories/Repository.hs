module Domain.Repositories.Repository
    ( Repository
    )
where

import           Control.Monad.Trans.Reader     ( ReaderT )
import           Database.HDBC.MySQL            ( Connection )
import           Data.Pool                      ( Pool )

type Repository a = ReaderT (Pool Connection) IO a
