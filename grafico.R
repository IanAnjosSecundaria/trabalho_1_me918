library(jsonlite)
library(ggplot2)
dados = read.csv(config$bd)


# Dados de previs??o e valores reais
valores_reais = dados[[config$var_resposta]]  # Vari??vel resposta real dos dados
valores_previstos = read_json("saidas//predicoes.json") # Previs??es no conjunto de dados de treino

# Cria um dataframe para plotar
df_plot = data.frame(Previsto = unlist(valores_previstos), Real = valores_reais)

# Gr??fico Real vs Previsto
ggplot(df_plot, aes(x = Previsto, y = Real)) +
  geom_jitter(aes(color = "Real"), size = 2) +  # Pontos reais em azul
  geom_point(aes(x = Previsto, y = Previsto, color = "Previsto"), size = 2) +  # Pontos previstos em vermelho
  geom_segment(aes(x = Previsto, y = Previsto, xend = Previsto, yend = Real), linetype = "dashed", color = "gray") +  # Linhas conectando pontos
  scale_color_manual(values = c("Real" = "blue", "Previsto" = "red")) +  # Definir cores para pontos reais e previstos
  geom_abline(slope = 1, intercept = 0, linetype = "solid", color = "black") +  # Linha ideal
  labs(title = "Gr??fico Real vs Previsto", x = "Previsto", y = "Real") +
  theme_minimal() +
  theme(legend.title = element_blank())

