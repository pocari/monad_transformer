module Main where

import           Control.Monad.Trans.Maybe
import           Control.Monad.Trans.Class      ( lift )

main :: IO ()
main = do
  x <- runMaybeT foo
  print x

hoge :: IO (Maybe Int)
hoge = return $ Just 123

foo :: MaybeT IO Int
foo = do
  x <- MaybeT hoge
  lift $ print $ "debug output ... " ++ (show x)
  return (x + 10)


