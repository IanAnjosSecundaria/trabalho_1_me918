library(jsonlite)

modelo = readRDS("saidas/modelo.rds")
novos_dados = config$predicao

# Inicializa um vetor vazio para armazenar as previsões
preds = c()

# Loop para prever cada valor na lista
for (dados in novos_dados) {
  if (config$tipo_modelo == 'lm') {
    # Previsão para o modelo linear
    previsao = predict(modelo, newdata = data.frame(config$predicao = dados))  # Substitua 'x' pelo nome da variável usada no seu modelo
  } else if (config$tipo_modelo == 'lasso') {
    # Previsão para o modelo Lasso
    X_new = as.matrix(data.frame(config$predicao = dados))  # Substitua 'x' pelo nome da variável usada no seu modelo
    previsao = predict(modelo, newx = X_new)
  }
  
  # Armazena a previsão
  preds = c(preds, previsao)
}

# Exibe as previsões
print(preds)

write_json(preds, "saidas/predicoes.json")
