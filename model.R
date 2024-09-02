# Bibliotecas:
library(yaml)
library(glmnet)

# Bibliotecas autorais:
source("config.R")
source(modelos)

chamar_modelo = function() {
	# Lógica:
	config = yaml::read_yaml(paste0(pasta_input, "/", arquivo_yaml))

	# Carregar os dados
	dados = read.csv(config$bd)

	X = as.matrix(dados[, config$var_preditoras])
	y = dados[[config$var_resposta]]

	modelo_funcao = function(x, y, dados) {
	  regressao = paste0(y, "~", x)
	  ajuste = lm(as.formula(regressao), data = dados)
	  return(list(beta0 = ajuste$coef[1], beta1 = ajuste$coef[2]))
	}

	modelo_usado = config$tipo_modelo
	if (modelo_usado == 'lm') {
	  modelo = modelo_funcao(config$var_preditoras, config$var_resposta, dados)
	} else if (modelo_usado == 'lasso') {
	  modelo = glmnet(X, y, alpha = config$lasso_params$alpha,
		              lambda = config$lasso_params$lambda)
	} else {
	  stop(paste("Modelo", config$tipo_modelo, "não é reconhecido. Use 'lm' ou 'lasso'."))
	}
	
	return(modelo)
}

salvar_modelo = function(modelo) {
  # Salvar o modelo
  nome_modelo = paste0(pasta_output, "/modelo_",gsub(".yaml", "", arquivo_yaml), "_", modelo_usado,".rds")
  saveRDS(modelo, nome_modelo)
  print(paste0("Modelo salvo em ", pasta_output, " com o nome '", nome_modelo, "'"))
}

