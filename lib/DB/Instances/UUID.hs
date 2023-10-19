{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS_GHC -Wno-orphans #-}

module DB.Instances.UUID where

import Data.UUID.Types
import Database.SQLite.Simple
import Database.SQLite.Simple.FromField
import Database.SQLite.Simple.Internal
import Database.SQLite.Simple.Ok
import Database.SQLite.Simple.ToField

instance FromField UUID where
    fromField f@(Field (SQLText txt) _) = case fromText txt of
        Just r  -> Ok r
        Nothing -> returnError ConversionFailed f "need a uuid"
    fromField f = returnError ConversionFailed f "need a uuid"

instance ToField UUID where
    toField = SQLText . toText
