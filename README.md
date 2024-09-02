# trabalho_1_me918

## Como usar

[tutorial uso]

## Da organização do repositório

Esse repositório está organizado em:

Arquivos de aplicação:
- model.R;
- plot.R;
- prediction.R;
- treatment.R;
- config.R.

Arquivos de função/suporte:
- functions_treatment.R.

Pastas de iterações:
- entrada;
- saida.

## Variáveis dentro do yaml:

- tipo_modelo: string que indica o modelo escolhido, podem ser dois, ou o *lm* ou o *lasso*;
- bd: string com o nome do ".csv", o arquivo ".csv" deve estar na pasta "entrada", caso ela esteja na pasta principal, ao iniciar, o código pega todos os ".csv" e joga na pasta "entrada";
- var_preditora: É uma lista de strings onde cada item dentro da lista é o nome de uma coluna que será usado como variável preditora;
- var_resposta: É uma string que indica o nome da coluna da variável resposta;
- lambda: É um float, que em determinados modelos é usado como parâmetro, por exemplo, no lasso esse parâmetro é usado;

## Como o usuário deve iteragir com o programa

Na pasta, entradas deixe o arquivo .csv onde a primeira linha deve ser as colunas; No arquivo usuario.yaml, é precisso colocar uma série de parâmetros para o funcionamento do programa a depender do modelo selecionado:

### **Para regressão linear**

- tipo_modelo: *lm*;
- bd: "Nome do '.csv' que será usado, esse '.csv' tem que estar na pasta entradas";
- var_preditoras: 'O nome de uma ou mais colunas preditoras, é uma lista';
- var_respostas: 'O nome de uma coluna resposta, é uma string';
- plot: '0 ou 1, caso queira o plot é 1, por padrão é 0'.

### **Para regressão lasso**

- tipo_modelo: *lasso*;
- bd: "Nome do '.csv' que será usado, esse '.csv' tem que estar na pasta entradas";
- var_preditoras: 'O nome de uma ou mais colunas preditoras, é uma lista';
- var_respostas: 'O nome de uma coluna resposta, é uma string';
- plot: '0 ou 1, caso queira o plot é 1, por padrão é 0';
- lambda: 'Parâmetro lâmbida do *lasso*.

### **Para previsão**

- tipo_modelo: *lm* ou *lasso*
- bs: "Nome do '.csv' que será usado, esse '.csv' tem que estar na pasta entradas";
- dados_predicao: "Lista de listas com variáveis preditoras afim de receber o Y do modelo".

