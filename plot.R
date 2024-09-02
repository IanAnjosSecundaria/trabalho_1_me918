# plot Pedro.F

dados = read.csv(config$dataset)
preds_json = fromJSON("local_de_saida/predicoes.json")

ggplot(data = dados, aes(x = preds_treino, y = dados[[config$response_var]])) +
  geom_point() +
  geom_vline(xintercept = preds_json, linetype = "dashed", color = "red") +
  ggtitle("Predições vs Valores Observados") +
  xlab("Predições") +
  ylab("Valores Observados") +
  theme_minimal()

ggsave("saidas/grafico.pdf")
