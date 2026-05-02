import Funcoes

main :: IO ()
main = do
  receitas <- carregarReceitas
  print receitas