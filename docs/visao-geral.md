---
hide:
  - navigation
---

# Arquitetura

Esta seção descreve o passo a passo completo da pipeline de forma geral.

![Arquitetura do Projeto](images/arquitetura.png)


## 1. Preparação dos Dados

- Realizamos o download do dataset histórico de corridas da Fórmula 1 no [Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020).
- Exploramos os arquivos CSV para entender as tabelas disponíveis e os relacionamentos entre elas.

---

## 2. Modelagem Relacional

- A partir da análise, construímos um [modelo entidade-relacionamento (ER)](modelo-ER.md)
- Criamos scripts SQL para:
  - Criação das tabelas no **SQL Server**.
  - Inserção dos dados a partir dos arquivos CSV.

---

## 3. Instanciar Banco Relacional

- Instanciamos um banco de dados SQL Server na nuvem, com as tabelas populadas.
- Esse banco relacional serviu como **fonte para a extração de dados bruta** da pipeline.

---

## 4. Armazenamento em Nuvem: Azure Data Lake

- Criamos uma conta de armazenamento no **Azure Data Lake Gen2**.
- Estruturamos os dados nas seguintes camadas conforme a **arquitetura em formato de medalhão**:
  - `landing`: Dados brutos extraídos do SQL Server.
  - `bronze`: Dados organizados por pastas/tabelas, mas ainda sem transformações profundas.
  - `silver`: Dados limpos, com joins, nomes padronizados e tipos convertidos.
  - `gold`: Tabelas analíticas prontas para visualização e exploração (fatos e dimensões).

---

## 5. Processamento com Databricks + PySpark

- Utilizamos o **Azure Databricks** para construir os notebooks responsáveis por:
  - Ingestão dos dados de cada camada do Data Lake.
  - Aplicação das transformações.
  - Construção do **modelo dimensional** com tabelas de fatos e dimensões.

---

## 6. Visualização de Dados

- Utilizando o **Databricks**  construímos dashboards que apresentam:
  - Os **pilotos mais rápidos por circuito** ao longo dos anos.
  - As **pistas com maior número de acidentes e colisões**.

---

## 7. Provisionamento com Terraform 

- Algumas partes do ambiente (como a criação do Azure Data Lake) foram automatizadas com **Terraform**, permitindo versionamento e reuso da infraestrutura.
