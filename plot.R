library(ggplot2)
dados = read.csv(config$bd)

# Dados de previsão e valores reais
valores_reais = dados[[config$var_resposta]]  # Variável resposta real dos dados
valores_previstos = predict(modelo, newx = X)  # Previsões no conjunto de dados de treino

# Cria um dataframe para plotar
df_plot = data.frame(Previsto = valores_previstos, Real = valores_reais)

# Gráfico Real vs Previsto
ggplot(df_plot, aes(x = Previsto, y = Real)) +
  geom_point(aes(color = "Real"), size = 2) +  # Pontos reais em azul
  geom_point(aes(x = Previsto, y = Previsto, color = "Previsto"), size = 2) +  # Pontos previstos em vermelho
  geom_segment(aes(x = Previsto, y = Previsto, xend = Previsto, yend = Real), linetype = "dashed", color = "gray") +  # Linhas conectando pontos
  scale_color_manual(values = c("Real" = "blue", "Previsto" = "red")) +  # Definir cores para pontos reais e previstos
  geom_abline(slope = 1, intercept = 0, linetype = "solid", color = "black") +  # Linha ideal
  labs(title = "Gráfico Real vs Previsto", x = "Previsto", y = "Real") +
  theme_minimal() +
  theme(legend.title = element_blank())
