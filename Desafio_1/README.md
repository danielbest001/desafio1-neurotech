=# Desafio de Automação Web - Kabum! com Robot Framework

Este projeto contém um script de automação para testar o fluxo de compra de um produto no e-commerce da Kabum!.

## Estrutura do Projeto 📂
- **tests/**: Contém os arquivos de teste que descrevem os cenários.
- **resources/**: Contém os arquivos com a implementação das keywords.
- **results/**: Pasta de destino para os relatórios e logs gerados após a execução.
- **requirements.txt**: Lista as dependências Python do projeto.

## Pré-requisitos
- Python 3.8 ou superior
- PIP (gerenciador de pacotes do Python)
- Google Chrome

## Configuração do Ambiente ⚙️
1. Clone este repositório para sua máquina local.
2. Navegue até a pasta raiz do projeto (`desafio_1/`) pelo terminal.
3. Instale as dependências listadas no `requirements.txt` com o seguinte comando:
    ```bash
    pip install -r requirements.txt
    ```

## Como Executar ▶️
Para rodar a automação, execute o seguinte comando no terminal, a partir da pasta raiz do projeto. O argumento `-d results/` instrui o Robot a salvar todos os arquivos de saída na pasta `results`.

```bash
robot -d results/ tests/
```

## Resultados Esperados 📊
Após a execução bem-sucedida, a pasta `results/` conterá os seguintes arquivos:
- `log.html`: Log detalhado com cada passo da execução.
- `report.html`: Relatório de alto nível com o status final do teste.
- `output.xml`: Arquivo XML com os dados brutos da execução.