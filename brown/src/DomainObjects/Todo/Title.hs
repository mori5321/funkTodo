module DomainObjects.Todo.Title
    ( Title(..)
    )
where

import           GHC.Generics                   ( Generic )
import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )
newtype Title = Title String deriving (FromJSON, ToJSON, Generic, Show)
