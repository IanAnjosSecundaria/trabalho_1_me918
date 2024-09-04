# Sempre que o usuário pedir uma requisição na ferramenta o yaml deve ser recriado;
# O código deve tratar o yaml que chega de forma a o 'model.R' conseguir entender a requisição;

# Bibliotecas autorais
source("config.R")
source(funcoes_tratamento)

# Lógica
pastas = c("entradas", "saidas")
lapply(pastas, criar_pasta)
criar_yaml()


