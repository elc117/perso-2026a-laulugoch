module Testes where

import Funcoes

rodarTestes :: IO ()
rodarTestes = do
  receitas <- carregarReceitas

  putStrLn "\nTESTE 1 - Possiveis"
  print (recomendarPossiveis ["ovo","leite","farinha","acucar","fermento"] receitas)

  putStrLn "\nTESTE 2 - Quase possiveis"
  print (recomendarQuase ["ovo","leite","farinha"] receitas)

  putStrLn "\nTESTE 3 - Quase possiveis ordenado"
  print (recomendarQuaseOrdenado ["ovo","leite","farinha"] receitas)

  putStrLn "\nTESTE 4 - Filtrar por tipo"
  print (filtrarPorTipo "doce" receitas)

  putStrLn "\nTESTE 5 - Possiveis + tipo"
  print (recomendarPossiveis ["ovo","leite","farinha","acucar"] (filtrarPorTipo "doce" receitas))

  putStrLn "\nTESTE 6 - Quase possiveis + tipo"
  print (recomendarQuaseOrdenado ["ovo","leite","farinha"] (filtrarPorTipo "doce" receitas))

  putStrLn "\nTESTE 7 - Exclusao"
  print (filtrarExclusao
    ["acucar","leite","leite condensado","queijo","sal","ovo","pao","carne","frango"] receitas)