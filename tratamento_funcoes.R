#install.packages("yaml") primeira vez ao executar o código para preparar o ambiente
library(yaml)

#Função para criar pastas
criar_pasta = function(pasta) {
	  if (!dir.exists(pasta)) {
			dir.create(pasta)
			message(paste("Pasta", pasta, "criada."))
	  } else {
			message(paste("Pasta", pasta, "já existe."))
	  }
}

# Funções de tratamento
criar_yaml = function() {
	  criar_yaml = function() {
	  # Caminho do arquivo
	  caminho_arquivo = "entradas/meu_arquivo.yaml"
	  
	  # Verifica se o arquivo j?? existe
	  if (!file.exists(caminho_arquivo)) {
		dados = list(
		  bd = "banco de dados", # string
		  var_preditora = "x", # string
		  var_resposta = "y", # string
		  dados_predicao = list(4, 19), # lista de listas
		  tipo_modelo = "modelo", # string
		  lambda = 0.01, # float
		  plot = 0
		)
		yaml_string = as.yaml(dados)
		write(yaml_string, file = caminho_arquivo)
		cat("Arquivo YAML criado com sucesso.\n")
	  } else {
		cat("O arquivo YAML j?? existe.\n")
	  }
	}
}

# Função para conferir se requisição é valida
conferir_requisicao = function(pasta_input, arquivo_yaml) {
	  # Lê o arquivo YAML
	  requisicao = yaml::read_yaml(paste0(pasta_input, "/", arquivo_yaml))
	  
	  # Função para validar variáveis de acordo com o tipo de modelo
	  validar_modelo <- function(requisicao) {
			tipo_modelo <- requisicao$tipo_modelo
			
			if (tipo_modelo == "lm") {
				  campos_obrigatorios = c("bd", "var_preditora", "var_resposta", "plot")
			} else if (tipo_modelo == "lasso") {
				  campos_obrigatorios = c("bd", "var_preditora", "var_resposta", "plot", "lambda")
			} else if (tipo_modelo == "lm" || tipo_modelo == "lasso") {
			 	 campos_obrigatorios = c("bd", "dados_predicao")
			} else {
			 	 stop("Tipo de modelo desconhecido. Use 'lm', 'lasso' ou 'previsao'.")
			}
			
			# Verifica se todos os campos obrigatórios estão presentes
			for (campo in campos_obrigatorios) {
				  if (!campo %in% names(requisicao)) {
						stop(paste("Campo obrigatório faltando:", campo))
				  }
			}
	}
	return(TRUE)
}

