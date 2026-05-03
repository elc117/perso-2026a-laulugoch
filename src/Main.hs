{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Funcoes
import Data.Aeson (object, (.=))

main :: IO ()
main = do
  receitas <- carregarReceitas

  scotty 3000 $ do

    -- rota teste
    get "/health" $ do
      json (object ["status" .= ("ok" :: String)])

    -- lista todas as receitas
    get "/receitas" $ do
      json receitas