# Backend Web com Haskell+Scotty

## 1. Identificação

- Nome: Lauren Auth Lugoch
- Curso: Sistemas de Informação

---

## 2. Tema/objetivo

O tema do trabalho é desenvolver um Sistema de Recomendação de Receitas desenvolvido em Haskell e utilizando Scotty. 

O sistema tem como objetivo recomendar receitas com base nos ingredientes informados pelo usuário. Além de listar receitas possíveis de serem feitas com os ingredientes disponíveis, o sistema também recomenda "receitas quase possíveis", priorizando opções onde o usuário já possui pelo menos 50% dos ingredientes necessários. Ainda, permite a filtragem por tipo de receita (doce ou salgado) e também a exclusão de receitas com ingredientes indesejados.

A lógica principal aplica a programação funcional, onde todas as regras de recomendação são implementadas por funções puras, sem dependência da camada web. também foram usadas funções de alta ordem (como filter, map, any, all), e a interface web foi construída utilizando o framework Scotty, servindo apenas como camada de entrada e saída de dados.

---

## 3. Processo de desenvolvimento

O desenvolvimento do projeto foi iniciado com a definição de uma estrutura simples de receitas armazenadas em JSON, contendo nome, tipo e a lista de ingredientes. A partir disso, fui desenvoveldendo as lógicas e definições das funcionalidades que eu queria e as funções necessárias. Conforme criava as funções eu ia testando-as dentro de um arquivo Testes.hs bem simples, ou através de chamadas das funções pelo terminal.

Primeiramente, eu havia começado o desenvolvimento pelo VSCode, e apesar das funções e rotas estarem certas, o serviço web não carregava e não mostrava as saídas certas, nem mesmo usando curl. Então, migrei para o Codespaces e deu certo. 

Tive um pouco de dificuldade em relação à transformar os dados do arquivo receitas.json para o registro Receita em Haskell, mas isso foi facilmente solucionado com um pouco de pesquisa e também com a ajuda de IAs, que me ambientaram melhor sobre algumas propriedades próprias da linguagem que facilitaram muito essa parte. Outro ponto que dificultou bastante foi que, ao tentar usar 'param' sempre aparecei o erro de "função param fora de escopo". Tentei diversas correções diferentes, ajudas de IAs diferentes, com diversas tentativas usando diferentes import e rebuilds sucessivos com cabal build e cabal run. POrtanto, oprocesso envolveu várias tentativas até entender que a solução correta era ajustar a função utilizada na rota, e não apenas os imports, usando 'queryParam' no lugar de  'param'.

Sobre a contrução das funções, comecei com as funcionalidades básicas, como a recomendação das receitas possíveis e das quase possíveis e depois fui ajustando para melhorar a lógica e separar as funções em funcionalidades específicas. Depois, também aprimorei a seleção das receitas quase possíveis para selecionar somente receitas em que o usuário já tivesse 50% dos ingredientes, para evitar casos de recomendar receitas com 8 ingredientes, por exemplo, e o usuário só possuir 1 ingrediente. Além disso, também deixei as receitas quase possíveis ordenadas, das mais possíveis (80% de compatibilidade entre os ingredientes do usuário e os ingredientes da receita) para as menos possíveis (apenas 50% de compatibilidade entre os ingredintes).

Utilizei bastantes aspectos da linguagem funcional apresentados em aula, como o uso de filter, map, all, length, entre outros, mas também descobri e apliquei algumas propriedades novas como flip e sortBy.

---

## 4. Testes

Eu fiz os testes das funções conforme fui desenvolvendo elas. Realizei os testes tanto no terminal, seguindo esses passos: 1º usar ‘cabal repl’, 2º carregar dados usando ‘receitas <- carregarReceitas’, 3º chamar as funções com parâmetros; como também através de um arquivo Teste.hs que chama diretamente as funções de Funcoes.hs e simula diferentes cenários de ingredientes do usuário. Mantive o arquivo com esses testes dentro do trabalho, ele testa cada uma das funções individualmente:
- recomendarPossiveis ["ovo","leite","farinha","acucar","fermento"] receitas

- recomendarQuase ["ovo","leite","farinha"] receitas

- recomendarQuaseOrdenado ["ovo","leite","farinha"] receitas

- filtrarPorTipo "doce" receitas

- recomendarPossiveis ["ovo","leite","farinha","acucar"] (filtrarPorTipo "doce" receitas)

- recomendarQuaseOrdenado ["ovo","leite","farinha"] (filtrarPorTipo "doce" receitas)

- filtrarExclusao ["acucar","leite","leite condensado","queijo","sal","ovo","pao","carne","frango"] receitas

Um exemplo testando recomendarPossiveis e filtrarPorTipo manualmente no terminal:
    ghci> recomendarPossiveis ["ovo","leite","farinha","acucar"] (filtrarPorTipo "doce" receitas)

    [Receita {nome = "panqueca doce", tipo = "doce", ingredientes = ["farinha","ovo","leite","acucar"]}]

---

## 5. Execução

As dependências são com o cabal update, cabal build e cabal run.

Para executar uso cabal run, que abria a porta 3000 e dava acesso à https://bookish-parakeet-4j6vqqqrwpj53qgw4-3000.app.github.dev/ no navegador, ou usando http://localhost:3000/ com curl em outro terminal.

A partir disso são usadas as rotas contidas no arquivo Main.hs:

- /receitas: mostra todas as receitas contidas no arquivo receitas.json.
- /possivel: /possiveis?ingredientes=ingrediente1,ingrediente2,ingrediente3,ingrediente4,...
- /quase: /quase?ingredientes=ingrediente1,ingrediente2,ingrediente3
- /possiveis-por-tipo: /possiveis-por-tipo?ingredientes=ingrediente1,ingrediente2,ingrediente3&tipo=doce ou salgado
- /quase-por-tipo: /quase-por-tipo?ingredientes=ingrediente1,ingrediente2,ingrediente3&tipo=doce ou salgado
- /exclusao: /exclusao?evitar=ingrediente1,ingrediente2,ingrediente3

OBSERVAÇÃO SOBRE OS PARÂMETROS: Os parâmetros de ingredientes devem ser enviados separados por vírgula **sem espaços**, pois o sistema não realiza remoção automática de espaços.

---

## 6. Deploy

Link do serviço publicado: <https://sistema-receitas-r7cg.onrender.com>

Segui as orientações que estavam no material da aula sobre Web Service em Haskell e tive ajuda do Gemini Pro para fazer as alterações necessários nos arquivos render.yaml e no Dockerfile.

---

## 7. Resultado final

[Link do vídeo](https://youtu.be/Hznz5baNv88)

No vídeo de demonstração, é mostrado o funcionamento do sistema através do terminal utilizando comandos curl. Cada requisição representa um cenário diferente de uso da aplicação, validando as funções puras implementadas no backend e sua integração com as rotas HTTP.

As execuções demonstradas são:

/receitas: retorna todas as receitas disponíveis no sistema, carregadas a partir do arquivo JSON.
/possiveis: exibe apenas as receitas que podem ser totalmente preparadas com os ingredientes fornecidos.
/quase: retorna receitas em que o usuário já possui pelo menos parte relevante dos ingredientes (mínimo de 50%).
/possiveis-por-tipo: filtra receitas por tipo (ex: doce ou salgado) e retorna apenas as possíveis com os ingredientes informados.
/quase-por-tipo: combina o filtro por tipo com a recomendação de receitas quase possíveis, ordenadas por maior compatibilidade.
/exclusao: remove receitas que contenham ingredientes proibidos informados pelo usuário.

---

## 8. Uso de IA 

### 8.1 Ferramentas de IA utilizadas

- ChatGPT plano Free
- Gemini 3.1 Pro 

---

### 8.2 Interações relevantes com IA

#### Interação 1

- **Objetivo da consulta:** Estruturar o tipo de dado Receita para ser compatível com JSON.
- **Trecho do prompt ou resumo fiel:** Como eu faço a leitura do json e converto para um dado em Haskell.
- **O que foi aproveitado:** A estrutura do data Receita e as instâncias de FromJSON/ToJSON.
- **O que foi modificado ou descartado:** Foi apenas adicionado a estrutura de data Receita e e FromJSON e ToJSON.

#### Interação 2

- **Objetivo da consulta:** Configurar o servidor Scotty para ler parâmetros da URL.
- **Trecho do prompt ou resumo fiel:** Mostrei o erro que estava dando ao usar param e pedi como corrigir isso sem usar param.
- **O que foi aproveitado:** O uso de queryParam e a função splitOn da biblioteca Data.List.Split.
- **O que foi modificado ou descartado:** Alterei a linha que pega o dado vindo na URL para  ingredientesParam <- queryParam "ingredientes".

#### Interação 3 

- **Objetivo da consulta:** Organização de testes manuais em Haskell.
- **Trecho do prompt ou resumo fiel:** Como testar as funções puras no GHCi.
- **O que foi aproveitado:** Uso de chamadas diretas no terminal.
- **O que foi modificado ou descartado:** Agrupamento em arquivo Testes.hs.

---

### 8.3 Exemplo de erro, limitação ou sugestão inadequada da IA

Em algumas respostas, a IA sugeriu bibliotecas ou funções que não estavam incluídas no projeto ou no cabal (ex: funções de pretty print ou módulos adicionais). Foi necessário ajustar removendo essas dependências e mantendo apenas bibliotecas padrão já configuradas no cabal. E também errou bastante ao me ajudar na correção do erro em relação ao uso de 'param'.

---

### 8.4 Comentário pessoal sobre o processo envolvendo IA

O uso de IA foi uma ferramenta importante para acelerar o desenvolvimento e me ajudar a compreender as estruturas iniciais do projeto, especialmente conceitos novos como a criação de APIs e o funcionamento do fluxo de um backend web em Haskell. Além disso, a IA foi de grande ajuda na organização inicial do arquivo .cabal, me auxiliando a mapear e configurar corretamente as dependências necessárias para que o projeto compilasse (como aeson, scotty e split). Teve momentos em que as IAs me atrapalharam ao darem soluções erradas e atrasarem o desenvolvimento.