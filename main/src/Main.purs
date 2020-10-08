module Main where

import Options.Applicative (execParser, idm, info, strOption, long, Parser, ParserInfo)
import Prelude
import Effect (Effect)

main :: Effect Unit
main = execParser opts # void

opts :: ParserInfo String
opts = info sample idm

sample :: Parser String
sample = strOption $ long "hello"
