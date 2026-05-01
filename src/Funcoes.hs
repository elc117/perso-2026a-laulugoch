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