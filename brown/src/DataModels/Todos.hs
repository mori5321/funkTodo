{-# LANGUAGE TemplateHaskell #-}

module DataModels.Todos where

import           Data.Int                       ( Int32 )
import           DataModels.DataSource          ( defineTable )

$(defineTable "todos")
