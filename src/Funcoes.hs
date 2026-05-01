{-# LANGUAGE OverloadedStrings #-}

module Funcoes where

import Data.Aeson
import qualified Data.ByteString.Lazy as B

data Receita = Receita
{
  nome :: String,
  tipo :: String,
  ingredientes :: [String]
} deriving (Show)

instance FromJSON Receita where

instance FromJSON Receita where
  parseJSON = withObject "Receita" $ \v ->
    Receita
      <$> v .: "nome"
      <*> v .: "tipo"
      <*> v .: "ingredientes"