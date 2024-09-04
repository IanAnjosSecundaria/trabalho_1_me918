# Bibliotecas:
library(yaml)
library(glmnet)
library(assertthat)
# Bibliotecas autorais:
source("config.R")

# Uma vez tendo o yaml definido, treina o modelo
chamar_modelo = function(config) {
  
  dados = read.csv(config$bd)
  
  X = as.matrix(dados[, config$var_preditoras])
  y = dados[[config$var_resposta]]
  
  modelo_funcao = function(x, y, dados) {
    regressao = paste0(y, "~", x)
    ajuste = lm(as.formula(regressao), data = dados)
    return(list(beta0 = ajuste$coef[1], beta1 = ajuste$coef[2]))
  }
  
  modelo_usado = config$tipo_modelo
  
  # Verifique se o tipo de modelo foi definido
  assert_that(!is.null(modelo_usado) && modelo_usado != "", 
              msg = "Não setou nenhum tipo de modelo. Por favor, defina o tipo de modelo no arquivo YAML.")
  
  if (modelo_usado == 'lm') {
    modelo = modelo_funcao(config$var_preditoras, config$var_resposta, dados)
  } else if (modelo_usado == 'lasso') {
    # Verifique o número de variáveis preditoras
    assert_that(length(config$var_preditoras) >= 2, 
                msg = "Lasso precisa de pelo menos duas variáveis preditoras.")
    
    modelo = glmnet(X, y, alpha = config$lasso_params$alpha,
                    lambda = config$lasso_params$lambda)
  } else {
    stop(paste("Modelo", modelo_usado, "não é reconhecido. Use 'lm' ou 'lasso'."))
  }
  
  # Retornar uma lista com o modelo e o tipo de modelo
  return(list(modelo = modelo, tipo = modelo_usado))
}

# Função para salvar o modelo
salvar_modelo = function(modelo_obj) { 
  # Gerar o nome do arquivo baseado no tipo de modelo
  nome_modelo = paste0(pasta_output, "/modelo_", config$tipo_modelo, ".rds")
  
  # Salvar o modelo em um arquivo .rds
  saveRDS(modelo_obj, nome_modelo)
  
  # Imprimir mensagem de confirmação
  print(paste0("Modelo salvo em ", nome_modelo))
}

