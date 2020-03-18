{-# LANGUAGE ExistentialQuantification #-}

module UseCases.FetchTodoById
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
                                                , TodoID
                                                )
import qualified Domain.ValueObjects.Todo      as Todo

-- UseCaseがInfraレイヤーに依存してしまっている。
-- Infra層に依存させない方がよいのでは? -> DIしたい。
import           Domain.Repositories.TodoRepositoryClass
                                                ( TodoRepositoryClass(..)
                                                , fetchById
                                                )


data Repositories =  forall repo . TodoRepositoryClass repo
                    => Repositories { todoRepository :: repo }
data Input = Input { todoID :: TodoID }
data Output = Output { mTodo :: Maybe Todo }

execute :: Repositories -> Input -> UseCase Output
execute Repositories { todoRepository } Input { todoID } = do
    mTodo <- runRepository $ fetchById todoRepository todoID
    pure $ Output { mTodo = mTodo }
