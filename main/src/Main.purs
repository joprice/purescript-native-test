module Main where

import Data.List (intercalate)
import Data.Array as Array
import Data.Generic.Rep (class Generic)
import Options.Applicative (Parser, ParserInfo, argument, command, execParser, idm, info, many, metavar, progDesc, str, subparser)
import Prelude
import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = execParser opts # void 

run :: Sample -> Effect Unit
run (Hello targets) = log $ "Hello, " <> intercalate ", " targets <> "!"

run Goodbye = log "Goodbye."

opts :: ParserInfo Sample
opts = info (sample) idm

data Sample
  = Hello (Array String)
  | Goodbye

derive instance sampleEq :: Eq Sample

derive instance genericSample :: Generic Sample _

hello :: Parser Sample
hello = Hello <<< Array.fromFoldable <$> many (argument str (metavar "TARGET..."))

sample :: Parser Sample
sample =
  subparser
    ( command "hello"
        ( info hello
            (progDesc "Print greeting")
        )
    )
