#install.packages("yaml") primeira vez ao executar o código para preparar o ambiente

library(yaml)

# Funções de tratamento
criar_yaml = function() {
  dados = list(
    bd = "valor1",
    x = "valor3",
    y = "valor5",
    model = list(
      modelo_1 = 0,
      modelo_2 = 0
    ),
    lambda = "lambda",
    plot = 0
  )

  yaml_string <- as.yaml(dados)

  write(yaml_string, file = "meu_arquivo.yaml")
}





