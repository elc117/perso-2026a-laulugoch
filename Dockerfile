FROM haskell:9.8.4

WORKDIR /app

# Copia todos os arquivos do projeto para dentro do container
COPY . .

# Atualiza o cabal, constrói o seu executável "receitas" e o move para a pasta de binários
RUN cabal update && \
    cabal build && \
    cp "$(cabal list-bin receitas)" /usr/local/bin/receitas

# Comando que o Render vai executar para ligar o servidor
CMD ["receitas"]