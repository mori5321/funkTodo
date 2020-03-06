module Domain.ValueObjects.Todo.Body
    ( Body(..)
    )
where

import           GHC.Generics                   ( Generic )
import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )
newtype Body = Body String deriving (FromJSON, ToJSON, Generic, Show)
