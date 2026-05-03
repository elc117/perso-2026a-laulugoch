import Funcoes

main :: IO ()
main = do
  receitas <- carregarReceitas

  let teste1 = ["ovo", "farinha", "leite", "açucar"]
  let teste2 = ["ovo"]
  let teste3 = ["banana", "leite"]

  putStrLn "teste 1 (muitos ingredientes)"
  print (recomendarPossiveis teste1 receitas)
  print (recomendarQuase teste1 receitas)

  putStrLn "\nteste 2 (1 inrgediente) ==="
  print (recomendarPossiveis teste2 receitas)
  print (recomendarQuase teste2 receitas)

  putStrLn "\nteste 3 (2 ingredientes)"
  print (recomendarPossiveis teste3 receitas)
  print (recomendarQuase teste3 receitas)