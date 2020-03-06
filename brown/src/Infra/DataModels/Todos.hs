{-# LANGUAGE TemplateHaskell #-}

module Infra.DataModels.Todos where

import           Data.Int                       ( Int32 )
import           Infra.DataModels.DataSource          ( defineTable )

$(defineTable "todos")
