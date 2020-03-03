-- {-# LANGUAGE DataKinds  #-}
-- {-# LANGUAGE DeriveGeneric #-}
-- {-# LANGUAGE TypeOperators #-}
-- {-# LANGUAGE OverloadedStrings #-}
-- 
-- -- https://www.servant.dev/client-in-5-minutes.html
-- 
module HackageSample where
-- 
-- import Control.Applicative
-- import Control.Monad
-- import Control.Monad.IO.Class
-- import Data.Either
-- import Data.Aeson
-- import Data.Monoid
-- import Data.Proxy
-- import Data.Text (Text)
-- import GHC.Generics
-- import Servant.API
-- import Servant.Client (ServantError)
-- 
-- import qualified Data.Text as T
-- import qualified Data.Text.IO as T
-- 
-- type HackageAPI = "users" :> Get '[JSON] [UserSummary]
--              :<|> "user" :> Capture "username" Username :> Get '[JSON] UserDetailed
--              :<|> "packages" :> Get '[JSON] [Package]
-- 
-- type Username = Text
-- 
-- data UserSummary = UserSummary
--     { summaryUsername :: Username
--     , summaryUserid :: Int
--     } deriving (Eq, Show)
-- 
-- instance FromJSON UserSummary where
--   parseJSON (Object o) =
--     UserSummary <$> o .: "username"
--                 <*> o .:　"userid"
--   parseJSON _ = mzero
-- 
-- type Group = Text
-- 
-- data UserDetailed = UserDetailed
--     { username :: Username
--     , userid :: Int
--     , groups :: [Group]
--     } deriving (Eq, Show, Generic)
-- 
-- instance FromJSON UserDetailed
-- 
-- newtype Package = Package { packageName :: Text }
--     deriving (Eq, Show, Generic)
-- 
-- instance FromJSON Package
-- 
-- hackageAPI :: Proxy HackageAPI
-- hackageAPI = Proxy
-- 
-- getUsers :: Either ServantError IO [UserSummary]
-- getUser :: Username -> Either ServantError IO UserDetailed
-- getPackages :: Either ServantError IO [Package]
-- getUsers :<|> getUser :<|> getPackages = client hackageAPI $ BaseUrl Http "hackage.haskell.org" 80