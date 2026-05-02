{-# LANGUAGE OverloadedStrings #-}

module Funcoes where

import Data.Aeson
import qualified Data.ByteString.Lazy as B

data Receita = Receita
  { nome :: String
  , tipo :: String
  , ingredientes :: [String]
  } deriving (Show)

instance FromJSON Receita where
  parseJSON = withObject "Receita" $ \v ->
    Receita
      <$> v .: "nome"
      <*> v .: "tipo"
      <*> v .: "ingredientes"

carregarReceitas :: IO [Receita]
carregarReceitas = do
  conteudo <- B.readFile "src/receitas.json"
  let receitas = decode conteudo :: Maybe [Receita]
  case receitas of
    Just rs -> return rs
    Nothing -> return []

possuiTodos :: [String] -> Receita -> Bool
possuiTodos ingredientesUsuario receita = all (`elem` ingredientesUsuario) (ingredientes receita) 

recomendarPossiveis :: [String] -> [Receita] -> [Receita]
recomendarPossiveis ingredientesUsuario receitas = filter (possuiTodos ingredientesUsuario) receitas

receitasQuase :: [String] -> [Receita] -> [Receita]
receitaQuase 