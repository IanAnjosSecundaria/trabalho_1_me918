# Bibliotecas:
library(yaml)
library(glmnet)
library(assertthat)

# Bibliotecas autorais:
source("config.R")

# Uma vez tendo o yaml definido, treina o modelo
chamar_modelo = function(config) {
  
  # Carregar os dados do CSV usando o caminho especificado em config
  dados = read.csv(paste0(pasta_input, "/", config$bd))
  
  # Extração das variaveis preditoras como matriz e a variável resposta como vetor
  X = as.matrix(dados[, config$var_preditora])
  y = dados[[config$var_resposta]]
  
  # Função para ajuste do modelo linear simples ou m??ltiplo
  modelo_funcao = function(var_preditora, y, dados) {
    # Construir a fórmula com todas as vari??veis preditoras
    regressao = as.formula(paste(y, "~", paste(var_preditora, collapse = " + ")))
    ajuste = lm(regressao, data = dados)
    return(ajuste)
  }
  
  modelo_usado = config$tipo_modelo
  
  # Verifique se o tipo de modelo foi definido
  assert_that(!is.null(modelo_usado) && modelo_usado != "", 
              msg = "N??o setou nenhum tipo de modelo. Por favor, defina o tipo de modelo no arquivo YAML.")
  
  if (modelo_usado == 'lm') {
    modelo = modelo_funcao(config$var_preditora, config$var_resposta, dados)
    
  } else if (modelo_usado == 'lasso') {
    # Verifique o número de variavéis preditoras
    assert_that(length(config$var_preditora) >= 2, 
                msg = "Lasso precisa de pelo menos duas vari??veis preditoras.")
    
    # Pegue os valores de alpha e lambda dos par??metros lasso
    alpha = config$alpha
    lambda = config$lambda
    
    # Verifique se alpha e lambda são válidos
    assert_that(!is.null(alpha), msg = "Valor de alpha n??o foi definido.")
    assert_that(!is.null(lambda), msg = "Valor de lambda n??o foi definido.")
    
    # Executar o modelo Lasso
    modelo = glmnet(X, y, alpha = alpha, lambda = lambda)
    
  } else {
    stop(paste("Modelo", modelo_usado, "n??o ?? reconhecido. Use 'lm' ou 'lasso'."))
  }
  
  # Retornar uma lista com o modelo e o tipo de modelo
  return(list(modelo = modelo, tipo = modelo_usado))
}

# Função para salvar o modelo
salvar_modelo = function(modelo_obj) { 
  # Verificar se a pasta de saída existe
  if (!dir.exists(pasta_output)) {
    dir.create(pasta_output, recursive = TRUE)
  }
  
  # Gerar o nome do arquivo baseado no tipo de modelo presente em config$tipo_modelo
  nome_modelo = paste0(pasta_output, "/modelo_", config$tipo_modelo, ".rds")
  
  # Salvar o modelo em um arquivo .rds
  saveRDS(modelo_obj, nome_modelo)
  
  # Imprimir mensagem de confirmação
  print(paste0("Modelo salvo em ", nome_modelo))
}
