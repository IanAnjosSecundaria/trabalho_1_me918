# Configura????o de imagem
# Caso o usu??rio j?? tenha no seu diret??rio a imagem de configura????o, ent??o basta pegar essas configura????es da imagem.
install.packages("renv")

inicializar_configuracoes_programa = function() {
	if (!dir.exists("renv")) {
	  renv::init()
	  renv::install("yaml")
	  renv::install("glue")
	  renv::install("glmnet")
	  renv::install("assertthat")
	  renv::install("jsonlite")
	  renv::snapshot()
	} else {
	  message("A pasta 'renv' j?? existe. Apenas executando a restaura????o.")
	  renv::restore()
	}
}
