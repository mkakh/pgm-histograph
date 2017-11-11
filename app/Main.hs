module Main where
import Lib
import System.Environment (getArgs)

main :: IO ()
main = do
    filePaths <- getArgs
    plotPGMs filePaths 
