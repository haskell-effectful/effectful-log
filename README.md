# log-effectful

Adaptation of the [log-base](https://hackage.haskell.org/package/log-base)
library for the effectful ecosystem.

## Example

A sample usage for logging to both standard output and Elasticsearch:

```haskell
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Effectful
import Effectful.Log
import Log
import Log.Backend.ElasticSearch
import Log.Backend.StandardOutput

main :: IO ()
main = runEff $ do
  let config = defaultElasticSearchConfig
        { esServer = "http://localhost:9200"
        , esIndex  = "logs"
        }
  withStdOutLogger $ \stdoutLogger -> do
    withElasticSearchLogger config $ \esLogger -> do
      runLog "main" (stdoutLogger <> esLogger) defaultLogLevel $ do
        logInfo_ "Hi there"
```
