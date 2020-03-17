module Domain.Repositories.TodoRepositoryClass where

import           Domain.ValueObjects.Todo       ( Todo
                                                , TodoID
                                                )
import           Data.Pool                      ( Pool )
import           Control.Monad.Trans.Reader     ( ReaderT )
import           Database.HDBC.MySQL            ( Connection )
import           Handlers.Common                ( Handler )
import           Domain.Repositories.Repository ( Repository )

class TodoRepositoryClass a where
   list :: a -> Repository [Todo]
   store :: a -> Todo -> Repository ()
