# Código principal com a lógica principal de requisição
source("config.R")
source(virtualizacao)
source(tratamento)
source(funcoes_tratamento)
source(modelos)
source(predicao)
source(plot)



# Tratamento principal:
inicializar_configuracoes_programa()
criar_pasta()
criar_yaml()

# Após o usuário modificar o yaml:
if(conferir_requisicao(pasta_input, arquivo_yaml))
{
	#Depois de conferir a requisição
	#COLOCAR O CÓDIGO DO MODEL.R
	#COLOCAR O CÓDIGO DO PREDICTION.R
	#COLOCAR O CÓDIGO DO PLOT.R
}

