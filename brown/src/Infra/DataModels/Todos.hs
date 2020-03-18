{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Infra.DataModels.Todos
    ( Todos(..)
    , insertTodos
    , todos
    , convert
    , adapt
    , id'
    )
where

import           Prelude                        ( Maybe(Nothing) )
import           Data.Int                       ( Int32 )
import           Infra.DataModels.DataSource    ( defineTable )
import qualified Domain.ValueObjects.Todo      as Todo
import           Domain.ValueObjects.Todo       ( Todo
                                                , makeTodo
                                                , unwrapTodo
                                                )

$(defineTable "todos")

convert :: Todos -> Todo
convert Todos { id, body } = makeTodo id body

adapt :: Todo -> Todos
adapt todo = Todos { id = id, body = body, doneAt = Nothing }
    where (id, body) = unwrapTodo todo
