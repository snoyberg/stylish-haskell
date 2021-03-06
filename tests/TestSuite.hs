--------------------------------------------------------------------------------
module Main
    ( main
    ) where


--------------------------------------------------------------------------------
import           Test.Framework                               (defaultMain)


--------------------------------------------------------------------------------
import qualified StylishHaskell.Parse.Tests
import qualified StylishHaskell.Step.Imports.Tests
import qualified StylishHaskell.Step.LanguagePragmas.Tests
import qualified StylishHaskell.Step.Records.Tests
import qualified StylishHaskell.Step.Tabs.Tests
import qualified StylishHaskell.Step.TrailingWhitespace.Tests
import qualified StylishHaskell.Step.UnicodeSyntax.Tests


--------------------------------------------------------------------------------
main :: IO ()
main = defaultMain
    [ StylishHaskell.Parse.Tests.tests
    , StylishHaskell.Step.Imports.Tests.tests
    , StylishHaskell.Step.LanguagePragmas.Tests.tests
    , StylishHaskell.Step.Records.Tests.tests
    , StylishHaskell.Step.Tabs.Tests.tests
    , StylishHaskell.Step.TrailingWhitespace.Tests.tests
    , StylishHaskell.Step.UnicodeSyntax.Tests.tests
    ]
