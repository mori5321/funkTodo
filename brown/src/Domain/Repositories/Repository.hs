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
-- この階層が外部のことを知りすぎ。(HandlerがReaderTをもっていること)
-- 例えばIORef IO aみたいなのも受け取れるようにしたい。それによりMemory上のStoreに切り替えられるようにする。
-- 疑問: 直和にしてしまうのはありなのか? 
-- 例: type Repository a = ConnectionPoolReaderT IO a | IORef IO a
-- 論点: 複数種のの型に対応するための修正範囲がどこまで及ぶか? 非常に限定的ならばこれでもよいかもしれない。
type Repository a = ConnectionPoolReaderT IO a

