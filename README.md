# trabalho_1_me918

## Istruções de Uso

Execute o código ```main.R```.

## Organização do Repositório

Este repositório está organizado da seguinte forma:

Arquivo principal:
- ```main.R```.

Arquivos de Aplicação:
- ```config.R```;
- ```tratamento.R```;
- ```treinamento.R```;
- ```predicao.R```;
- ```grafico.R```.

Arquivos de Função/Suporte:
- ```tratamento_funcoes.R```.

Pastas de Iterações:
- entrada;
- saida.

## Variáveis no Arquivo YAML

As variáveis no arquivo YAML incluem:

- **tipo_modelo**: String que indica o modelo escolhido, podendo ser *lm* ou *lasso*.
- **bd**: String contendo o nome do arquivo *.csv*. Este arquivo deve estar na pasta *entrada*. Caso esteja na pasta principal, o código moverá automaticamente todos os arquivos *.csv* para a pasta *entrada* ao iniciar;
- **var_preditora**: Lista de strings, onde cada item representa o nome de uma coluna que será utilizada como variável preditora;
- **var_resposta**: String que indica o nome da coluna que contém a variável resposta;
- **lambda**: Valor numérico (float) utilizado como parâmetro em determinados modelos, como no lasso;
- **dados_predicao** : Valor/lista de valores numéricos( float) que serão utilizados para fazer a predição.
## Interação do Usuário com o Programa

O usuário deve seguir estas instruções para interagir com o programa:

1. Na pasta *entrada*, coloque o arquivo *.csv* contendo os dados. A primeira linha do arquivo deve conter os nomes das colunas;
2. No arquivo *usuario.YAML*, configure os parâmetros necessários para o funcionamento do programa, de acordo com o modelo selecionado.

### **Para regressão linear**

- **tipo_modelo**: *lm*;
- **bd**:  Nome do arquivo *.csv* que será utilizado. Este arquivo deve estar na *pasta* entrada;
- **var_preditoras**: Nome de uma ou mais colunas preditoras, representadas como uma lista;
- **var_respostas**: Nome da coluna que contém a variável resposta, representado como uma string;
- **plot**: 0 ou 1. Defina como 1 para gerar um gráfico.

### **Para regressão lasso**

- **tipo_modelo**: *lasso*;
- **bd**:  Nome do arquivo *.csv* que será utilizado. Este arquivo deve estar na *pasta* entrada;
- **var_preditoras**: Nome de 2 ou mais colunas preditoras, representadas como uma lista;
- **var_respostas**: Nome da coluna que contém a variável resposta, representado como uma string;
- **plot**: 0 ou 1. Defina como 1 para gerar um gráfico;
- **lambda**: Parâmetro lambda utilizado no modelo *lasso*.

### **Parâmetros para Previsão**

- **tipo_modelo**: *lasso*;
- **bd**:  Nome do arquivo *.csv* que será utilizado. Este arquivo deve estar na *pasta* entrada;
- **dados_predicao**: Lista de listas contendo as variáveis preditoras para gerar as previsões do modelo.

## Descrição dos códigos

### ```main.R```

Este é o arquivo principal, responsável pela operação do conjunto de códigos. O usuário deve executá-lo após especificar sua requisição no arquivo *.YAML*.

### ```config.R```

Código é responsável pela definição dos nomes de arquivos e pastas utilizados ao longo da execução do programa.

### ```tratamento.R``` e ```tratamento_funcoes.R```

Esta seção do código é responsável pelo tratamento do arquivo de entrada *.YAML* fornecido pelo usuário, bem como pela execução das solicitações de treinamento ou predição do modelo.
A seguir estão algumas das funções presentes no código:

- **criar_pasta**: Função que cria as pastas necessárias para o processo de treinamento, predição e requisição do usuário;
- **criar_YAML**: Função que gera o arquivo YAML que será utilizado pelo usuário para fazer a requisição;
- **conferir_requisicao**: Função que verifica se a requisição do usuário está corretamente formatada e se é possível prosseguir com as chamadas das funções subsequentes.

### ```treinamento.R```

Parte do código responsável pelo treino de modelos.
A seguir estão algumas das funções presentes no código:

- **chamar_modelo**: Função que invoca o modelo e retorna o objeto do modelo ajustado;
- **salvar_modelo**: Função que salva o modelo ajustado com o nome especificado pelo usuário.

### ```predicao.R```

Parte do código responsável pela previsão dos modelos, vai gerar um...
A seguir estão algumas das funções presentes no código:


### ```grafico.R```

Parte do código responsável pelo treino de modelos.
