module Test.Main where

import Parser as Parser
import Prelude
import Effect (Effect)
import Effect.Class.Console (log)

main :: Effect Unit
main = do
  log "🍝"
  log "You should add some tests."
  Parser.main
