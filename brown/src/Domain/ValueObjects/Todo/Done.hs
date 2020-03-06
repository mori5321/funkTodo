module Domain.ValueObjects.Todo.Done
    ( Done(..)
    )
where

import           GHC.Generics                   ( Generic )
import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )
newtype Done = Done Bool deriving (FromJSON, ToJSON, Generic, Show)
