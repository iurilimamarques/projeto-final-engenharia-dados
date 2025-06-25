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

## Passo a Passo para Configuração da Estrutura do Projeto

1. **Clonar o repositório do projeto**  
   Execute o comando abaixo para clonar este repositório em sua máquina local:
   ```bash
   git clone https://github.com/iurilimamarques/projeto-final-engenharia-dados.git
   ```

2. **Provisionar a infraestrutura via Terraform**  
   O Terraform do projeto já contempla a criação dos principais recursos, incluindo a instância do banco de dados SQL Server e a conta de armazenamento do Data Lake.  
   Execute os comandos abaixo dentro do diretório onde estão os arquivos do Terraform:
   ```bash
   terraform init
   terraform validate
   terraform fmt
   terraform plan
   terraform apply
   ```

3. **Executar os scripts de criação e inserção de tabelas**  
   Após a criação da infraestrutura, localize os scripts SQL no repositório (possivelmente na pasta `sql/` ou similar) e execute-os na instância do SQL Server provisionada para criar as tabelas e inserir os dados necessários.

4. **Provisionar um cluster do Databricks**  
   Crie uma conta no Databricks e provisione um cluster dentro do workspace associado à sua assinatura Azure.

5. **Integrar o Databricks com o Azure Data Lake**  
   Realize a integração entre o Databricks e o Azure Data Lake, garantindo que o cluster Databricks tenha permissão de acesso ao armazenamento criado.

6. **Executar a pipeline de dados**  
   Siga as instruções presentes na seção [Pipeline de Dados](pipeline/bronze.md) para rodar a pipeline, movimentando e processando os dados conforme a arquitetura do projeto.

---
