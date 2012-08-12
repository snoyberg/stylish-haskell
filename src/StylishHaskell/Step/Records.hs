--------------------------------------------------------------------------------
module StylishHaskell.Step.Records where


--------------------------------------------------------------------------------
import           Control.Arrow                   (second)
import           Data.List                       (nub)
import qualified Language.Haskell.Exts.Annotated as H


--------------------------------------------------------------------------------
import           StylishHaskell.Editor
import           StylishHaskell.Util


--------------------------------------------------------------------------------
records :: H.Module l -> [[H.FieldDecl l]]
records modu =
    [ fields
    | H.Module _ _ _ _ decls                     <- [modu]
    , H.DataDecl _ _ _ _ cons _                  <- decls
    , H.QualConDecl _ _ _ (H.RecDecl _ _ fields) <- cons
    ]


--------------------------------------------------------------------------------
-- | Align the types of a field
alignType :: Int -> H.FieldDecl H.SrcSpan -> Change String
alignType longest (H.FieldDecl srcSpan _ _) =
    changeLine (H.srcSpanStartLine srcSpan) alignType'
  where
    alignType' str =
        let (pre, post) = second (drop 2) $ break (== ':') str
        in [padRight longest pre ++ post]


--------------------------------------------------------------------------------
-- | Find the length of the longest field name in a record
longestFieldName :: [H.FieldDecl H.SrcSpan] -> Int
longestFieldName fields = maximum
    [ H.srcSpanEndColumn $ H.ann name
    | H.FieldDecl _ names _ <- fields
    , name                  <- names
    ]


--------------------------------------------------------------------------------
-- | Checks that all no field of the record appears on more than one line,
-- amonst other things
fixable :: [H.FieldDecl H.SrcSpan] -> Bool
fixable []     = False
fixable fields = all singleLine srcSpans && nonOverlapping srcSpans
  where
    srcSpans          = map H.ann fields
    singleLine s      = H.srcSpanStartLine s == H.srcSpanEndLine s
    nonOverlapping ss = length ss == length (nub $ map H.srcSpanStartLine ss)