library(jsonlite)

# Carrega o modelo salvo
modelo = readRDS("saidas/modelo.rds")
novos_dados = config$predicao

# Inicializa um vetor para armazenar as previsões
preds = c()

if (config$tipo_modelo == 'lm') {
  # Extrai os coeficientes do modelo (assumindo que estão armazenados em uma lista)
  betas = unlist(modelo)
  
  # Converte a lista de novos_dados em uma matriz
  X_new = t(do.call(rbind, lapply(novos_dados, as.numeric)))
  
  # Adiciona uma coluna de 1's para o intercepto
  X_new = cbind(1, X_new)
  # Calcula as previsões multiplicando a matriz de preditores por beta
  preds = X_new %*% betas
  
} else if (config$tipo_modelo == 'lasso') {
  # Converte a lista de novos_dados em uma matriz para o Lasso
  X_new = do.call(rbind, lapply(novos_dados, as.numeric))
  preds = predict(modelo, newx = X_new)
}

# Salva as previsões em um arquivo JSON
write_json(as.numeric(preds), "saidas/predicoes.json")
