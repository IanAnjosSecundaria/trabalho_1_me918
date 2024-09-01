"""modelo."""
library(yaml)
library(glmnet)

config <- yaml::read_yaml("arq_de_config.yaml")

#dados já estão no dir
dados <- read.csv(config$nomde_dos_dados)

X <- as.matrix(dados[, config$var_preditoras])
y <- dados[[config$var_resposta]]

if (config$tipo_de_modelo == 'lm') {
  modelo <- lm(as.formula(paste(config$var_resposta, "~",
               paste(var_preditoras, collapse = "+"))), data = dados)
} else if (config$tipo_de_modelo == 'lasso') {
  modelo <- glmnet(X, y, alpha = config$lasso_params$alpha,
                   lambda = config$lasso_params$lambda)
#podemos adicionar ifelse para mais modelos
}

#precisamos adicionar o caminho
saveRDS(modelo, "local_de_salvamento/modelo.rds")
