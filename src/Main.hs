import Funcoes

main :: IO ()
main = do
  receitas <- carregarReceitas
  let minhas = ["ovo", "farinha", "leite", "açucar"]
  let resultado = recomendarPossiveis minhas receitas
  print resultado