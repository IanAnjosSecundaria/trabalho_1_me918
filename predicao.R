# Bibliotecas:
library(yaml)
library(glmnet)
library(assertthat)
# Bibliotecas autorais:
source("config.R")


rodar_predicao <- function() {
  # Caminho para o modelo salvo
  nome_modelo = paste0(pasta_output, "/modelo_", config$tipo_modelo, ".rds")
  
  # Carrega o modelo salvo
  modelo_obj = readRDS(nome_modelo)
  
  # Verifica se o modelo está em uma lista e extrai o modelo
  if (is.list(modelo_obj) && !is.null(modelo_obj$modelo)) {
    modelo = modelo_obj$modelo
  } else {
    modelo = modelo_obj
  }
  
  # Novos dados para predição
  novos_dados = config$dados_predicao
  
  # Inicializa um vetor para armazenar as previs??es
  preds = c()
  
  if (config$tipo_modelo == 'lm') {
    # Extrai os coeficientes do modelo
    betas = unlist(modelo$coefficients)
    
    # Converte a lista de novos_dados em uma matriz
    X_new = t(do.call(rbind, lapply(novos_dados, as.numeric)))
    
    # Adiciona uma coluna de 1's para o intercepto, se necess??rio
    X_new = cbind(1, X_new)
    
    # Calcula as previsões multiplicando a matriz de preditores por beta
    preds = X_new %*% betas
    
  } else if (config$tipo_modelo == 'lasso') {
    
    # Converte 'dados_predicao' em uma matriz
    X_new = matrix(unlist(novos_dados), nrow = 1)
    
    # Verifica se a quantidade de variáveis corresponde ao modelo
    if (ncol(X_new) != nrow(modelo$beta)) {
      stop("O número de preditores nos novos dados não corresponde ao modelo Lasso treinado.")
    }
    
    # Fazer previsões usando o modelo Lasso
    preds = predict(modelo, newx = X_new, s = config$lambda)
  }
  # Salva as previsões em um arquivo JSON
  write_json(as.numeric(preds), paste0(pasta_output, "/predicoes.json"))
  
  return(preds)

}

