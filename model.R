#Bibliotecas:
library(yaml)
library(glmnet)

#Lógica:
config = yaml::read_yaml("entradas//meu_arquivo.yaml")

#dados jC! estC#o no dir
dados = read.csv(config$bd)

X = as.matrix(dados[, config$var_preditoras])
y = dados[[config$var_resposta]]


modelo_funcao = function(x, y, dados){
  regressao = paste0(y, "~", x)
ajuste = lm(as.formula(regressao), data = dados)
return(list(beta0 = ajuste$coef[1], beta1 = ajuste$coef[2]))
}

if (config$tipo_modelo == 'lm') {
  modelo = modelo_funcao(config$var_preditoras, config$var_respostas, dados)
} else if (config$tipo_modelo == 'lasso')
  {
  modelo = glmnet(X, y, alpha = config$lasso_params$alpha,
                   lambda = config$lasso_params$lambda)
#podemos adicionar ifelse para mais modelos
}

#precisamos adicionar o caminho
saveRDS(modelo, "saidas/modelo.rds")
