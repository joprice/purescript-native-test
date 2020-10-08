module Parser where

import Data.Either (Either(..))
import Prelude
import Effect (Effect)
import Effect.Console (log)
import Text.Parsing.Parser (Parser, ParserT, runParser, parseErrorPosition)
import Text.Parsing.Parser.String (eof, string, char, satisfy, anyChar)
import Control.Alt ((<|>))
import Text.Parsing.Parser.Expr (Assoc(..), Operator(..), buildExprParser)

digit :: Parser String Int
digit =
  (string "0" >>= \_ -> pure 0)
    <|> (string "1" >>= \_ -> pure 1)
    <|> (string "2" >>= \_ -> pure 2)
    <|> (string "3" >>= \_ -> pure 3)
    <|> (string "4" >>= \_ -> pure 4)
    <|> (string "5" >>= \_ -> pure 5)
    <|> (string "6" >>= \_ -> pure 6)
    <|> (string "7" >>= \_ -> pure 7)
    <|> (string "8" >>= \_ -> pure 8)
    <|> (string "9" >>= \_ -> pure 9)

parse = runParser "a" digit

main :: Effect Unit
main = case parse of
  Right result -> log $ show result
  Left err -> log $ show err
