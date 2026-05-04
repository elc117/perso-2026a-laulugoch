FROM haskell:9.8.4

WORKDIR /app

COPY . .

# Expõe a porta 3000 para o Render
EXPOSE 3000

# Compila o seu projeto "receitas" e prepara para execução
RUN cabal update && \
    cabal build && \
    cp "$(cabal list-bin receitas)" /usr/local/bin/receitas

CMD ["receitas"]