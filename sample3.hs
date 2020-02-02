module Sample3 where

import           Control.Monad                  ( forM_ )
import           Control.Monad.State
import           Data.IORef                     ( IORef
                                                , newIORef
                                                , modifyIORef
                                                , readIORef
                                                )

sample3_1 :: IO ()
sample3_1 = do
  ref <- newIORef (0 :: Int)
  modifyIORef ref (+ 3)
  result <- readIORef ref
  putStrLn $ "result ... " ++ show result

sample3_2 :: IO Int
sample3_2 = (`evalStateT` 0) $ do
  forM_ [1 .. 10] $ \i -> do
    x <- get
    liftIO $ putStrLn $ show x ++ " + " ++ show i ++ " => " ++ show (x + i)
    modify (+ i)
  get

