module App
    ( app
    )
where

import qualified Handlers.TodoHandler          as TodoHandler
                                                ( API
                                                , handler
                                                )
import           Control.Monad.Trans.Reader     ( runReaderT )
import           Control.Monad.Logger           ( runStdoutLoggingT )
import           Servant                        ( (:>)
                                                , Server
                                                , serve
                                                , Application
                                                , Proxy(..)
                                                , hoistServer
                                                )
import           Network.Wai.Handler.Warp       ( runSettings
                                                , defaultSettings
                                                , setPort
                                                , setLogger
                                                )
import           Data.Pool                      ( Pool
                                                , createPool
                                                )
import           Database.HDBC.MySQL            ( Connection )
import           Database.HDBC                  ( disconnect )
import           Infra.DataModels.DataSource    ( connect )

type API = "todos" :> TodoHandler.API

api :: Proxy API
api = Proxy

makeApp :: IO Application
makeApp = do
    pool <- createPool connect disconnect 1 1 5
    pure $ serve api $ server pool

server :: Pool Connection -> Server API
server pool = hoistServer api (flip runReaderT pool) $ TodoHandler.handler

app :: IO ()
app = do
    putStrLn $ "running server on port: " <> show port
    app <- makeApp
    runSettings settings app
  where
    port     = 8080
    settings = setPort port $ defaultSettings
