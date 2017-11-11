module Lib (plotPGMs) where

import qualified Data.ByteString as B
import Graphics.Matplotlib
import Control.Exception (bracket)
import Control.Monad (forM_, replicateM)
import System.IO
import Math.NumberTheory.Logarithms(intLog2)

plotPGMs :: [FilePath] -> IO ()
plotPGMs filePaths =
    forM_ filePaths $ \filePath ->
        bracket
            (openFile filePath ReadMode)
            (\hdl -> hClose hdl)
            (\hdl -> plotPGM hdl)

plotPGM :: Handle -> IO ()
plotPGM hdl = do
    pgmBinary <- readPGM hdl
    let pgmLength = B.length pgmBinary
    let bin = 1+intLog2 pgmLength
    onscreen $ histogram (B.unpack pgmBinary) bin

readPGM :: Handle -> IO B.ByteString 
readPGM src = do
    replicateM 3 $ hGetLine src
    pgmBinary <- B.hGetContents src 
    return pgmBinary

