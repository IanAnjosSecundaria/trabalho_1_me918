library(jsonlite)

modelo = readRDS("local_de_salvamento/modelo.rds")

novos_dados = fromJSON("local_de_entrada/novos_dados.json")

if (config$model_type == 'lm') {
  preds <- predict(modelo, newdata = novos_dados)
} else if (config$model_type == 'lasso') {
  X_new <- as.matrix(novos_dados)
  preds <- predict(modelo, newx = X_new)
}

write_json(preds, "saidas/predicoes.json")
