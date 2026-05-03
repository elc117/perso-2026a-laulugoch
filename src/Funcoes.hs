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

ingredientesFaltando :: [String] -> Receita -> [String]
ingredientesFaltando ingredientesUsuario receita = filter (`notElem` ingredientesUsuario) (ingredientes receita)

possuiTodos :: [String] -> Receita -> Bool
possuiTodos ingredientesUsuario receita = null (ingredientesFaltando ingredientesUsuario receita)

possuiAlgum :: [String] -> Receita -> Bool
possuiAlgum ingredientesUsuario receita = any (`elem` ingredientesUsuario) (ingredientes receita)

recomendarPossiveis :: [String] -> [Receita] -> [Receita]
recomendarPossiveis ingredientesUsuario receitas = filter (possuiTodos ingredientesUsuario) receitas

proporcaoIngredientes :: [String] -> Receita -> Double
proporcaoIngredientes ingredientesUsuario receita =
  let total = length (ingredientes receita)
      tem = length (filter (`elem` ingredientesUsuario) (ingredientes receita))
  in fromIntegral tem / fromIntegral total

ehQuasePossivel :: [String] -> Receita -> Bool
ehQuasePossivel ingredientesUsuario receita =
  let p = proporcaoIngredientes ingredientesUsuario receita
  in p >= 0.5 && p < 1.0

recomendarQuase :: [String] -> [Receita] -> [(Receita, [String])]
recomendarQuase ingredientesUsuario receitas =
  let resultados = map (\r -> (r, ingredientesFaltando ingredientesUsuario r)) receitas
  in filter (\(r, _) -> ehQuasePossivel ingredientesUsuario r) resultados