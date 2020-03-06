module Domain.ValueObjects.Todo.ID
    ( ID(..)
    )
where

import           GHC.Int                        ( Int32 )
import           GHC.Generics                   ( Generic )
import           Data.Aeson                     ( FromJSON
                                                , ToJSON
                                                )

newtype ID = ID Int32 deriving (Show, Generic, FromJSON, ToJSON)
