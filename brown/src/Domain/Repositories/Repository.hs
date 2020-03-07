module Domain.Repositories.Repository
    ( Repository
    , ConnectionPoolReaderT
    )
where

import           Control.Monad.Trans.Reader     ( ReaderT )
import           Database.HDBC.MySQL            ( Connection )
import           Data.Pool                      ( Pool )



type ConnectionPoolReaderT = ReaderT (Pool Connection)
-- TODO: この型を抽象化したい
-- 例えばIORef IO aみたいなのも受け取れるようにしたい。それによりMemory上のStoreに切り替えられるようにする。
type Repository a = ConnectionPoolReaderT IO a
