{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Funcoes
import Data.Aeson (object, (.=))
import Data.List.Split (splitOn)
import qualified Data.Text.Lazy as TL

main :: IO ()
main = do
  receitas <- carregarReceitas

  scotty 3000 $ do

    get "/health" $ do
      json (object ["status" .= ("ok" :: String)])

    get "/receitas" $ do
      json receitas

    get "/possiveis" $ do
      ingredientesParam <- queryParam "ingredientes"
      let ingredientesUsuario = splitOn "," (TL.unpack ingredientesParam)
      json (recomendarPossiveis ingredientesUsuario receitas)

    get "/quase" $ do
      ingredientesParam <- queryParam "ingredientes"
      let ingredientesUsuario = splitOn "," (TL.unpack ingredientesParam)
      json (recomendarQuase ingredientesUsuario receitas)

    get "/possiveis-por-tipo" $ do
      ingredientesParam <- queryParam "ingredientes"
      tipoParam <- queryParam "tipo"

      let ingredientesUsuario = splitOn "," (TL.unpack ingredientesParam)
      let tipoDesejado = TL.unpack tipoParam

      let receitasFiltradas = filtrarPorTipo tipoDesejado receitas

      json (recomendarPossiveis ingredientesUsuario receitasFiltradas)

    get "/quase-por-tipo" $ do
      ingredientesParam <- queryParam "ingredientes"
      tipoParam <- queryParam "tipo"

      let ingredientesUsuario = splitOn "," (TL.unpack ingredientesParam)
      let tipoDesejado = TL.unpack tipoParam

      let receitasFiltradas = filtrarPorTipo tipoDesejado receitas

      json (recomendarQuaseOrdenado ingredientesUsuario receitasFiltradas)