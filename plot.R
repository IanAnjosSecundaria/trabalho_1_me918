# Carregar pacotes necess??rios
library(ggplot2)
library(jsonlite)

source("config.R")

plotar_grafico = function(config) {
  dados = read.csv(config$bd)
  preds_json = fromJSON(paste0(pasta_output, "/predicoes.json"))
  
  grafico = ggplot(data = dados, aes(x = preds_treino, y = dados[[config$var_preditoras]])) +
    geom_point() +  # Pontos dos valores preditos vs observados
    geom_vline(xintercept = preds_json, linetype = "dashed", color = "red") +  # Linhas verticais para as predicoes do JSON
    ggtitle("Preditos vs Observados") +  # Titulo do grafico
    xlab("Preditos") +  # Rótulo do eixo x
    ylab("Valores Observados") +  # Rotulo do eixo y
    theme_minimal()  # Tema minimalista
  
  # Salvar o gr??fico em PDF na pasta de sa??da
  ggsave(paste0("saidas/grafico_",config$tipo_modelo,".pdf"), plot = grafico)
}
