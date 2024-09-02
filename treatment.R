# tratamento
# Sempre que o usuário pedir uma requisição na ferramenta o yaml deve ser recriado;
# O código deve tratar o yaml que chega de forma a o 'model.R' conseguir entender a requisição;
# Já nesse código será puxado a função correta do modelo requisitado;


# Bibliotecas autorais
source("model.R")
source("treatment_functions.R")

# Bibliotecas não autorais


# Lógica:
pastas <- c("entradas", "saidas")
lapply(pastas, criar_pasta)
criar_yaml()

#Tenho que conferir o length(readRDS("saidas/modelo.rds")) é igual ao length da lista dados_predicao, se sim ele preve, caso contrário ele não preve

#Também tenho que conferir o que será retornado no plot


