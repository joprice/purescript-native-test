module Main where

import Prelude
import Effect (Effect)
import Options.Applicative.Help (renderHelp)
import Options.Applicative (Parser, ParserInfo, ParserPrefs, defaultPrefs, execParserPure, idm, info, long, strOption, ParserResult(..), ParserFailure(..), ParserHelp, CompletionResult(..))
import ExitCodes (ExitCode)
import ExitCodes as ExitCode
import Data.Tuple (Tuple(..))
import Data.Array as Array
import Data.Maybe (fromMaybe)
import Data.String as String
import Data.Newtype (un)
import Data.Tuple.Nested ((/\))
import Effect.Console (log)
import Data.Enum (fromEnum)

foreign import argv :: Effect (Array String)

getArgs :: Effect (Array String)
-- dropping the program name
getArgs = argv <#> Array.drop 1

getProgName :: Effect String
getProgName =
  argv
    <#> \args ->
        fromMaybe "" do
          executablePath <- Array.index args 1
          Array.last $ String.split (String.Pattern "/") executablePath

renderFailure :: ParserFailure ParserHelp -> String -> Tuple String ExitCode
renderFailure failure progn =
  let
    h /\ exit /\ cols /\ unit = un ParserFailure failure progn
  in
    Tuple (renderHelp cols h) exit

foreign import exit :: forall a. Int -> Effect a

exitWith :: forall void. ExitCode -> Effect void
exitWith c = exit $ fromEnum c

exitSuccess :: forall a. Effect a
exitSuccess = exit $ fromEnum ExitCode.Success

handleParseResult :: forall a. ParserResult a -> Effect a
handleParseResult (Success a) = pure a

handleParseResult (Failure failure) = do
  progn <- getProgName
  let
    Tuple msg exit = renderFailure failure progn
  {-
    stream = case exit of
      ExitCode.Success -> stdout
      _ -> stderr
      -}
  --void $ Stream.writeString stream UTF8 (msg <> "\n") mempty
  log (msg <> "\n")
  exitWith exit

handleParseResult (CompletionInvoked compl) = do
  progn <- getProgName
  msg <- (un CompletionResult compl).execCompletion progn
  log $ msg
  exitSuccess

-- void $ Stream.writeString stream UTF8 (msg <> "\n") mempty
-- exitWith exit
-- void $ Stream.writeString stdout UTF8 msg mempty
customExecParser :: forall a. ParserPrefs -> ParserInfo a -> Effect a
customExecParser pprefs pinfo =
  execParserPure pprefs pinfo <$> getArgs
    >>= handleParseResult

execParser :: forall a. ParserInfo a -> Effect a
execParser = customExecParser defaultPrefs

main :: Effect Unit
main = execParser opts >>= log

opts :: ParserInfo String
opts = info sample idm

sample :: Parser String
sample = strOption $ long "hello"
