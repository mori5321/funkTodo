
{-# LANGUAGE ExistentialQuantification #-}

module UseCases.RegisterTodo
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
                                                , store
                                                )


data Repositories =  forall repo . TodoRepositoryClass repo
                    => Repositories { todoRepository :: repo }
data Input = Input { todo :: Todo }
data Output = Output

execute :: Repositories -> Input -> UseCase Output
execute Repositories { todoRepository = todoRepository } Input { todo = todo }
    = do
        runRepository $ store todoRepository todo
        pure Output
