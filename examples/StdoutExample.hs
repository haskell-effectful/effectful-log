{-# LANGUAGE OverloadedStrings #-}

module StdoutExample (main) where

import Data.Text (Text)
import Effectful
import Effectful.Time (Time, runCurrentTimeIO)
import Log (LogLevel(LogInfo), logInfo)

import Effectful.Log
import Effectful.Log.Backend.StandardOutput

main :: IO ()
main = runEff $ do
  runCurrentTimeIO . runSimpleStdOutLogging "main" LogInfo $ do
    app

app :: (Logging :> es, Time :> es) => Eff es ()
app = do
  logInfo "Hello !" ("Some JSON payload" :: Text)
