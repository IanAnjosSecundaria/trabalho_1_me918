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

A lógica de maneira resumida do repositório pode ser visto logo abaixo:

![Grafo de Lógica Resumida](imagens_instrucoes/grafo_logica.png)

A lógica de maneira completa do repositório pode ser visto logo abaixo:

![Grafo de Lógica completa](imagens_instrucoes/grafico_logica_completa.png)

A organização do repositório pode ser visto logo abaixo:

![Grafo de Organização](imagens_instrucoes/grafo_organizacao.png)

## Variáveis no Arquivo YAML

As variáveis no arquivo YAML incluem:

- **tipo_modelo**: String que indica o modelo escolhido, podendo ser *lm* ou *lasso*.
- **bd**: String contendo o nome do arquivo *.csv*. Este arquivo deve estar na pasta *entrada*. Caso esteja na pasta principal, o código moverá automaticamente todos os arquivos *.csv* para a pasta *entrada* ao iniciar;
- **var_preditora**: Lista de strings, onde cada item representa o nome de uma coluna que será utilizada como variável preditora;
- **var_resposta**: String que indica o nome da coluna que contém a variável resposta;
- **lambda**: Valor numérico (float) utilizado como parâmetro em determinados modelos, como no lasso;
- **dados_predicao** : Valor/lista de valores numéricos (float) que serão utilizados para fazer a predição.

## Interação do Usuário com o Programa

O usuário deve seguir estas instruções para interagir com o programa:

1. Na pasta *entrada*, coloque o arquivo *.csv* contendo os dados. A primeira linha do arquivo deve conter os nomes das colunas;
2. No arquivo *meu_arquivo.YAML* que já é gerado para o usuário automaticamente, configure os parâmetros necessários para o funcionamento do programa, de acordo com o modelo selecionado.

## Parâmetros necessários para cada tipo de modelo

### **Para regressão linear**

- **tipo_modelo**: *lm*;
- **bd**:  Nome do arquivo *.csv* que será utilizado. Este arquivo deve estar na *pasta* entrada;
- **var_preditora**: Nome de uma ou mais colunas preditoras, representadas como uma lista;
- **var_resposta**: Nome da coluna que contém a variável resposta, representado como uma string;
- **plot**: 0 ou 1. Defina como 1 para gerar um gráfico.

### **Para regressão lasso**

- **tipo_modelo**: *lasso*;
- **bd**:  Nome do arquivo *.csv* que será utilizado. Este arquivo deve estar na *pasta* entrada;
- **var_preditora**: Nome de 2 ou mais colunas preditoras, representadas como uma lista;
- **var_resposta**: Nome da coluna que contém a variável resposta, representado como uma string;
- **plot**: 0 ou 1. Defina como 1 para gerar um gráfico;
- **lambda**: Parâmetro lambda utilizado no modelo *lasso*.

### **Parâmetros para Previsão**

- **tipo_modelo**: *lasso*;
- **bd**:  Nome do arquivo *.csv* que será utilizado. Este arquivo deve estar na *pasta* entrada;
- **dados_predicao**: Lista de listas contendo as variáveis preditoras para gerar as previsões do modelo.

### Instruções

Deve ser escolhido pelo usuário o modelo junto ao banco de dados e também na mesma "requisição" os *dados_predicao*. Pox exemplo:

```
bd: 'Diabetes.csv'
var_preditora: 
  - "glufast"
  - "sspg"
var_resposta: 'glutest'
dados_predicao:
  - 4.0
  - 19.0
tipo_modelo: 'lm'
lambda: 0.01
alpha : 1
plot: 1
```

## Descrição dos códigos

### ```main.R```

Este é o arquivo principal, responsável pela operação do conjunto de códigos. O usuário deve executá-lo após especificar sua requisição no arquivo *.YAML*.

### ```config.R```

Este código é responsável pela definição dos nomes de arquivos e pastas utilizados ao longo da execução do programa.

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

Parte do código responsável pela previsão dos modelos, vai gerar um arquivo *.rds* na pasta de saída.
A seguir está a função presente no código:

- **rodar_predicao**: Função que roda a predição de acordo com o arquivo *.rds* gerado pelo *treinamento.R* e gera um *.JSON*.

### ```grafico.R```

Parte do código responsável pelo treino de modelos.
A seguir está a função presente no código:

- **plotar**: Função feita para gerar um gráfico em *.PNG* plotar a variável de predição descrita pelo *.YAML* em conjunto do *.JSON* gerado na *predicao.R*.

