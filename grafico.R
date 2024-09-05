library(jsonlite)
library(ggplot2)


plotar = function(config) {
  if(config$plot != 0){
    dados = read.csv(paste0(pasta_input, "/", config$bd))
    
    
    # Dados de previsão e valores reais
    valores_reais = dados[[config$var_resposta]]
    valores_previstos = read_json(paste0(pasta_output, "/predicoes.json"))
    
    # Cria um dataframe para plotar
    df_plot = data.frame(Previsto = unlist(valores_previstos), Real = valores_reais)
    
    # Gráfico Real vs Previsto
    p = ggplot(df_plot, aes(x = Previsto, y = Real)) +
      geom_jitter(aes(color = "Real"), size = 2) +
      geom_point(aes(x = Previsto, y = Previsto, color = "Previsto"), size = 2) + 
      geom_segment(aes(x = Previsto, y = Previsto, xend = Previsto, yend = Real), linetype = "dashed", color = "gray") +
      scale_color_manual(values = c("Real" = "blue", "Previsto" = "red")) + 
      geom_abline(slope = 1, intercept = 0, linetype = "solid", color = "black") +
      labs(title = "Gr??fico Real vs Previsto", x = "Previsto", y = "Real") +
      theme_minimal() +
      theme(legend.title = element_blank())
      
      # Salva o gráfico
    ggsave(filename = paste0(pasta_output, "/grafico_real_vs_previsto.png"), plot = p)
  }
}
