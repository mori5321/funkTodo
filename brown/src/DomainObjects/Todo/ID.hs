module DomainObjects.Todo.ID
    ( ID(..)
    )
where

import           GHC.Generics                   ( Generic )
import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )

newtype ID = ID String deriving (Show, Generic, FromJSON, ToJSON)
