module Main where

import Data.List (intercalate)
import Data.Array as Array
import Control.Alt ((<|>))
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Options.Applicative ((<**>), Parser, ParserInfo, argument, command, commandGroup, execParser, helper, hidden, idm, info, many, metavar, progDesc, str, subparser)
import Prelude
import Control.Monad.Except (ExceptT(..), runExceptT)
import Data.Array (length)
import Data.Either (Either(..), either)
import Data.Traversable (traverse_, sequence)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log)

main :: Effect Unit
main = execParser opts >>= run

run :: Sample -> Effect Unit
run (Hello targets) = log $ "Hello, " <> intercalate ", " targets <> "!"

run Goodbye = log "Goodbye."

opts :: ParserInfo Sample
opts = info (sample <**> helper) idm

data Sample
  = Hello (Array String)
  | Goodbye

derive instance sampleEq :: Eq Sample

derive instance genericSample :: Generic Sample _

instance showSample :: Show Sample where
  show = genericShow

hello :: Parser Sample
hello = Hello <<< Array.fromFoldable <$> many (argument str (metavar "TARGET..."))

sample :: Parser Sample
sample =
  subparser
    ( command "hello"
        ( info hello
            (progDesc "Print greeting")
        )
        <> command "goodbye"
            ( info (pure Goodbye)
                (progDesc "Say goodbye")
            )
    )
    <|> subparser
        ( command "bonjour"
            ( info hello
                (progDesc "Print greeting")
            )
            <> command "au-revoir"
                ( info (pure Goodbye)
                    (progDesc "Say goodbye")
                )
            <> commandGroup "French commands:"
            <> hidden
        )
