#install.packages("yaml") primeira vez ao executar o código para preparar o ambiente

library(yaml)

# Funções de tratamento
criar_yaml = function() {
  dados = list(
    bd = "banco de dados", #string
    var_preditoras = "x", #string
    var_respostas = "y", #string
    dados_predicao = (4, 19), #lista de listas
    tipo_modelo = "modelo", #string
    lambda = 0.01, #float
    plot = 0
  )

  yaml_string = as.yaml(dados)

  write(yaml_string, file = "entradas/meu_arquivo.yaml")
}





