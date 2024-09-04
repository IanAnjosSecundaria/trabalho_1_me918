# Carregar pacotes necessários
library(ggplot2)
library(jsonlite)

source("config.R")

plotar_grafico = function() {
  config = yaml::read_yaml(paste0(pasta_input, "/", arquivo_yaml))
  
  dados = read.csv(config$dataset)
  preds_json = fromJSON("local_de_saida/predicoes.json")
  
  # Gerar o gráfico
  grafico <- ggplot(data = dados, aes(x = preds_treino, y = dados[[config$response_var]])) +
    geom_point() +  # Pontos dos valores preditos vs observados
    geom_vline(xintercept = preds_json, linetype = "dashed", color = "red") +  # Linhas verticais para as predições do JSON
    ggtitle("Predições vs Valores Observados") +  # Título do gráfico
    xlab("Predições") +  # Rótulo do eixo x
    ylab("Valores Observados") +  # Rótulo do eixo y
    theme_minimal()  # Tema minimalista
  
  # Salvar o gráfico em PDF na pasta de saída
  ggsave(paste0("saidas/grafico",config$tipo_modelo,".pdf"), plot = grafico)
}
