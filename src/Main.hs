{-# LANGUAGE OverloadedStrings #-}

import Funcoes

main :: IO ()
main = do
  receitas <- carregarReceitas

  let minhas = ["ovo", "farinha", "leite", "açucar"]

  putStrLn "RECEITAS POSSÍVEIS"
  print (recomendarPossiveis minhas receitas)

  putStrLn "\nRECEITAS QUASE POSSÍVEIS"
  print (recomendarQuase minhas receitas)