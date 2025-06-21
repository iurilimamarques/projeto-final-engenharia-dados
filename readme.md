# Pipeline de Dados – Fórmula 1

[![Docs](https://img.shields.io/badge/docs-mkdocs-blue)](https://iurilimamarques.github.io/projeto-final-engenharia-dados/)  

Repositório do projeto final da disciplina de Engenharia de Dados do curso de Engenharia de Software da UNISATC. Utilizamos dados históricos da Fórmula 1 para construir uma pipeline de dados completa, da ingestão à visualização de KPIs.

---

## Desenho de Arquitetura

![Arquitetura do Projeto](images/arquitetura.png)

---

## Pré-requisitos e Ferramentas Utilizadas

- **SQL Server**: Banco relacional para ingestão inicial
- **Azure Data Lake**: Armazenamento em nuvem das camadas de dados
- **Databricks + PySpark**: Processamento e transformação dos dados
- **Delta Lake**: Controle de versionamento e transações ACID
- **Terraform**: Provisionamento da infraestrutura em nuvem
- **MkDocs + Material**: Documentação do projeto

---

## Como Executar

Esse projeto roda majoritariamente em ambiente de nuvem (Azure + Databricks). Para reprodução local:

- Clonar o repositório do projeto:  
   ```bash
   git clone https://github.com/iurilimamarques/projeto-final-engenharia-dados.git```
- Instanciar o banco de dados SQL Server .
- Executar os [scripts](/SQL/) de criação e inserção de tabelas.
- Criar a conta de armazenamento no Azure e configurar o Data Lake.
- Criar uma conta e provisionar o cluster do Databricks.
- Usar Terraform para automatizar a criação de recursos.
- Integrar o Databricks com o Azure Data Lake.
- Executar a pipeline de dados conforme scripts.

---


## Autores

- [Ana Beatriz](https://github.com/AnaBeatrizMeller)
- [Iuri](https://github.com/iurilimamarques)
- [Julia](https://github.com/juliameller) 
- [Lucas](https://github.com/Lucaspaixao-code)
- [William](https://github.com/WilliamEspindolaCardoso)

---

## Licença

Este projeto está sob a licença **MIT**.  
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## Referências

- Dataset: [Formula 1 World Championship (1950 - 2024) – Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020)
- Scripts [Terraform](https://github.com/jlsilva01/adls-azure/)