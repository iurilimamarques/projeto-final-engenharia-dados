---
hide:
  - navigation
---

# ⚙️ Configuração do Ambiente

Esta página descreve como configurar as ferramentas e serviços necessários para executar o pipeline de dados.

## Serviços e ferramentas utilizados
- **Azure Data Lake Storage Gen2**
- **Azure Databricks**
- **SQL Server**
- **Terraform**
- **Python 3.x** 
- **Azure CLI** (para autenticação e gerenciamento de recursos)
- **Git + GitHub**

## Etapas de configuração
- Clonar o repositório do projeto:  
   ```bash
   git clone https://github.com/iurilimamarques/projeto-final-engenharia-dados.git```
- Instanciar o banco de dados SQL Server 
- Executar os scripts de criação e inserção de tabelas
- Criar a conta de armazenamento no Azure e configurar o Data Lake.
- Criar uma conta e provisionar o cluster do Databricks.
- Usar Terraform para automatizar a criação de recursos.
- Integrar o Databricks com o Azure Data Lake
- Executar a pipeline de dados conforme descrito na seção [Pipeline de Dados](pipeline/bronze.md)

