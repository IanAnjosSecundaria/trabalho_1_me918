source("config.R")
library(jsonlite)

# Carrega o modelo salvo
modelo_obj = readRDS("saidas/modelo_lm.rds")



if (is.list(modelo_obj) && !is.null(modelo_obj$modelo)) {
  modelo = modelo_obj$modelo
} else {
  modelo = modelo_obj
}


novos_dados = config$dados_predicao

# Inicializa um vetor para armazenar as previsões
preds = c()

if (config$tipo_modelo == 'lm') {
  # Extrai os coeficientes do modelo (assumindo que estão armazenados em uma lista)
  betas = unlist(modelo)
  
  # Converte a lista de novos_dados em uma matriz
  X_new = t(do.call(rbind, lapply(novos_dados, as.numeric)))
  
  # Adiciona uma coluna de 1's para o intercepto, se necessário
  X_new = cbind(1, X_new)
  
  # Calcula as previsões multiplicando a matriz de preditores por beta
  preds = X_new %*% betas
  
} else if (config$tipo_modelo == 'lasso') {
  
  X_new = do.call(rbind, lapply(novos_dados, as.numeric))
  
  # Verifique a estrutura do modelo
  if (is.list(modelo) && !is.null(modelo$beta)) {
    # O modelo Lasso pode ter o coeficiente em 'beta' ou não, dependendo da configuração
    betas = modelo$beta
  } else {
    stop("O modelo Lasso não contém os coeficientes esperados.")
  }
  
  # Verifique se a quantidade de variáveis corresponde ao modelo
  if (ncol(X_new) != length(betas)) {
    stop("O número de preditores nos novos dados não corresponde ao modelo Lasso treinado.")
  }
  
  # Fazer previsões usando o modelo Lasso
  preds = predict(modelo, newx = X_new, s = config$lambda)
}

# Salva as previsões em um arquivo JSON
write_json(as.numeric(preds), "saidas/predicoes.json")