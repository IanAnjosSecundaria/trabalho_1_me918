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
	  dados = list(
			bd = "banco de dados", #string
			var_preditoras = "x", #string
			var_respostas = "y", #string
			dados_predicao = (4, 19), #lista de listas
			tipo_modelo = "modelo", #string
			lambda = 0.01, #float
			plot = 0
	  )
	  yaml_string = as.yaml(dados)
	  write(yaml_string, file = "entradas/meu_arquivo.yaml")
}

# Função para conferir se requisição é válida
conferir_requisicao = function(pasta_input, arquivo_yaml) {
	  # Lê o arquivo YAML
	  requisicao = yaml::read_yaml(paste0(pasta_input, "/", arquivo_yaml))
	  
	  # Função para validar variáveis de acordo com o tipo de modelo
	  validar_modelo <- function(requisicao) {
			tipo_modelo <- requisicao$tipo_modelo
			
			if (tipo_modelo == "lm") {
				  campos_obrigatorios = c("bd", "var_preditoras", "var_respostas", "plot")
			} else if (tipo_modelo == "lasso") {
				  campos_obrigatorios = c("bd", "var_preditoras", "var_respostas", "plot", "lambda")
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
	  
	  # Função para validar a previsão
	  validar_previsao = function(requisicao) {
			modelo = readRDS("saidas/modelo.rds")
			tamanho_dados_predicao = length(requisicao$dados_predicao)
			
			if (length(modelo) != tamanho_dados_predicao) {
			  		stop("O tamanho de 'dados_predicao' não corresponde ao tamanho do modelo.")
			}
	  }
	  
	  # Validar modelo
	  validar_modelo(requisicao)
	  
	  # Se for previsão, valida adicionalmente a lista 'dados_predicao'
	  if (requisicao$tipo_modelo %in% c("lm", "lasso") && "dados_predicao" %in% names(requisicao)) {
			validar_previsao(requisicao)
	  }
	  
	  message("Requisição válida.")
	  return(TRUE)
}

# Exemplo de chamada da função
conferir_requisicao("caminho_para_input", "meu_arquivo.yaml")

