{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module App
    ( app
    )
where

import           Handlers.TodoHandler           ( TodosAPI
                                                , todosHandler
                                                )

import           Servant                        ( (:>)
                                                , Server
                                                , serve
                                                , Application
                                                , Proxy(..)
                                                )
import           Network.Wai.Handler.Warp       ( runSettings
                                                , defaultSettings
                                                , setPort
                                                , setLogger
                                                )

type API = "todos" :> TodosAPI

api :: Proxy API
api = Proxy

application :: Application
application = serve api server

server = todosHandler

app :: IO ()
app = do
    putStrLn $ "running server on port: " <> show port
    runSettings settings application
  where
    port     = 8080
    settings = setPort port $ defaultSettings
