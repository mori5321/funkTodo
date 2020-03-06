module Infra.DataModels.DataSource
    ( connect
    , defineTable
    )
where

import           Data.Int                       ( Int32 )
import           Database.HDBC.MySQL            ( connectMySQL
                                                , defaultMySQLConnectInfo
                                                , mysqlDatabase
                                                , Connection
                                                )
import           Database.HDBC.Schema.Driver    ( typeMap )
import           Database.HDBC.Query.TH         ( defineTableFromDB )
import           Database.HDBC.Schema.MySQL     ( driverMySQL )
import           GHC.Generics                   ( Generic )
import           Database.Relational.Config     ( defaultConfig
                                                , normalizedTableName
                                                )
import           Language.Haskell.TH            ( Q
                                                , Dec
                                                , TypeQ
                                                )

connect :: IO Connection
connect = connectMySQL defaultMySQLConnectInfo
    { mysqlDatabase = "INFORMATION_SCHEMA"
    }

defineTable :: String -> Q [Dec]
defineTable tableName = defineTableFromDB connect
                                          driverMySQL
                                          "funkTodo_development"
                                          tableName
                                          [''Show, ''Generic]
