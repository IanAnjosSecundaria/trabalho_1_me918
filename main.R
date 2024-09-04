# Código principal com a lógica principal de requisição
source("config.R")
source(virtualizacao)
inicializar_configuracoes_programa()
source(tratamento)
source(funcoes_tratamento)
source(modelos)
source(predicao)
source(plot)


# Tratamento principal:
criar_pasta(pasta_input)
criar_pasta(pasta_output)

# Após o usuário modificar o yaml:
if(conferir_requisicao(pasta_input, arquivo_yaml))
{
	config = yaml::read_yaml(paste0(pasta_input, "/", arquivo_yaml))
	
	#Depois de conferir a requisição
	modelo = chamar_modelo(config)
	salvar_modelo(modelo)
	rodar_predicao()
	plotar(config)
}

