# trabalho_1_me918

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

## Como o usuário deve iteragir com o programa:

Na pasta, entradas deixe o arquivo .csv onde a primeira linha deve ser as colunas; No arquivo usuario.yaml, é precisso colocar uma série de parâmetros para o funcionamento do programa a depender do modelo selecionado:

### **Para regressão logistica:**

- model: *lm*
- x: 'O nome de uma coluna';
- y: 'O nome de uma coluna';
- plot: ''

1. O X a coluna esperada, ou a lista de colunas separadas por ';', por exemplo: "coluna\_1;coluna\_2;coluna\_3";
3. Ainda no arquivo usuario.yaml, coloque: O nome do banco de dados, caso nenhum seja passado ele pegará o primeiro .csv da pasta; O X e o Y caso o modelo seja uma regressão

