module Funcoes where

data Receita = Receita
{
    nome :: String,
    tipo :: String,
    ingredientes :: [String]
} deriving (Show)