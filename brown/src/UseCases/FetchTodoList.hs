{-# LANGUAGE ExistentialQuantification #-}

module UseCases.FetchTodoList
    ( execute
    , Repositories(..)
    , Input(..)
    , Output(..)
    )
where


import           UseCases.UseCase               ( UseCase
                                                , runRepository
                                                )
import           Domain.ValueObjects.Todo       ( Todo
                                                , makeTodo
                                                )

-- UseCaseがInfraレイヤーに依存してしまっている。
-- Infra層に依存させない方がよいのでは? -> DIしたい。
import           Domain.Repositories.TodoRepositoryClass
                                                ( TodoRepositoryClass(..)
                                                , list
                                                )

data Input = Input {}
data Repositories =  forall a . TodoRepositoryClass a
                    => Repositories { todoRepository :: a
                                    }
data Output = Output { todos :: [Todo]
                     }

execute :: Repositories -> Input -> UseCase Output
execute Repositories { todoRepository = todoRepository } input = do
    todos <- runRepository $ list todoRepository
    pure $ Output { todos = todos }
