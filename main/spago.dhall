let List/concat =
      https://prelude.dhall-lang.org/List/concat sha256:54e43278be13276e03bd1afa89e562e94a0a006377ebea7db14c7562b0de292b

let deps = ./deps.dhall

in  { name = "my-project"
    , dependencies =
        List/concat
          Text
          [ [ "console"
            , "effect"
            , "parser"
            , "optparse"
            , "arrays"
            , "enums"
            , "exitcodes"
            , "maybe"
            , "newtype"
            , "prelude"
            , "strings"
            , "tuples"
            ]
          -- , deps
          ]
    , packages = ../packages.dhall
    , sources = [ "src/**/*.purs", "test/**/*.purs" ]
    -- , backend = "psgo"
    }
