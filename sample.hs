module Sample where

import           Control.Monad.Trans.Class      ( lift )
import           Control.Monad.Trans.State      ( StateT
                                                , state
                                                , evalStateT
                                                )
-- StateT の定義
-- newtype StateT s m a = StateT { runStateT :: s -> m (a,s) }
--
-- (`evalStateT` [0 :: Int]) 自体は IO モナド内にあるので、
-- その結果は IO モナドでないといけない。
-- evalStateの定義は
--
--   evalStateT :: (Monad m) => StateT s m a -> s -> m a
--   evalStateT m s = do
--       (a, _) <- runStateT m s
--       return a
--
-- であり、結果としては m a を返す。これがIOモナドなので、
-- 結果として、evalStateTの第一引数であるStateT 変換子の型は
-- StateT s IO a
-- になり、ここでは sの型は [Int]、aの型は Int なので
-- StateT [Int] IO Int
-- => [Int] -> IO (int, [Int])
-- になる
transTest2 :: IO ()
transTest2 = do
  x <- (`evalStateT` [0 :: Int]) $ do
    lift $ putStrLn "In State Monad"
    state $ \s -> (5 :: Int, 1 : s)
  print x
  return ()

stateMonad :: StateT [Int] IO Int
stateMonad = state $ \s -> (5, 1 : s)

