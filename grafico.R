# Carregar pacotes necessarios
library(ggplot2)
library(jsonlite)
library(yaml)

source("config.R")

plotar_grafico = function(config) {
  # Carregar os dados do CSV
  dados = read.csv(config$bd)
  
  # Verificar se todas as colunas de preditoras existem no dataframe
  colunas_existentes = all(config$var_preditoras %in% names(dados))
  
  if (!colunas_existentes) {
    stop("Uma ou mais colunas de variáveis preditoras não foram encontradas no dataset.")
  }
  
  if (!(config$var_resposta %in% names(dados))) {
    stop(paste("Coluna", config$var_resposta, "não encontrada no dataset."))
  }
  
  # Carregar as predições do JSON
  preds_json = fromJSON(paste0(pasta_output, "/predicoes.json"))
  
  # Vamos usar a primeira coluna de preditoras para o gráfico se forem várias colunas
  coluna_preditora = config$var_preditoras[1]
  
  # gráfico
  grafico = ggplot(data = dados, aes_string(x = coluna_preditora, y = config$var_resposta)) +
    geom_point() +  # Pontos dos valores preditos vs observados
    geom_vline(xintercept = preds_json, linetype = "dashed", color = "red") +  # Linhas verticais para as predições do JSON
    ggtitle("Preditos vs Observados") +  # Título do gráfico
    xlab("Preditos") +  # Rótulo do eixo x
    ylab("Valores Observados") +  # Rótulo do eixo y
    theme_minimal()  # Tema minimalista
  
  ggsave(paste0("saidas/grafico_", config$tipo_modelo, ".pdf"), plot = grafico)
}

config = yaml::read_yaml(paste0(pasta_input, "/", arquivo_yaml))
plotar_grafico(config)
