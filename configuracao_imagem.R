# Configuração de imagem
# Caso o usuário já tenha no seu diretório a imagem de configuração, então basta pegar essas configurações da imagem.

inicializar_configuracoes_programa = function() {
	if (!dir.exists("renv")) {
	  install.packages("renv")
	  renv::init()
	  renv::install("yaml")
	  renv::install("glue")
	  renv::install("glmnet")
	  renv::snapshot()
	} else {
	  message("A pasta 'renv' já existe. Apenas executando a restauração.")
	 renv::restore()
	}
}

