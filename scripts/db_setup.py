import pyodbc
import os
from dotenv import dotenv_values 

config = dotenv_values()

# --- Configurações ---
DB_SERVER = config.get('AZURE_SQL_SERVER_NAME')
DB_NAME = config.get('AZURE_SQL_DATABASE_NAME')
DB_USER = config.get('AZURE_SQL_ADMIN_USER')
DB_PASSWORD = config.get('AZURE_SQL_ADMIN_PASSWORD')

DDL_FILE_ENV_KEY = 'DDL_FILE_PATH'  
DDL_FILE_PATH_FROM_ENV = config.get(DDL_FILE_ENV_KEY)


def check_db_variables():
    """Verifica se as variáveis de ambiente para conexão com o banco e DDL foram definidas no arquivo .env."""
    missing_vars = []
    if not DB_SERVER:
        missing_vars.append("AZURE_SQL_SERVER_NAME")
    if not DB_NAME:
        missing_vars.append("AZURE_SQL_DATABASE_NAME")
    if not DB_USER:
        missing_vars.append("AZURE_SQL_ADMIN_USER")
    if not DB_PASSWORD:
        missing_vars.append("AZURE_SQL_ADMIN_PASSWORD")
    if not DDL_FILE_PATH_FROM_ENV:
        missing_vars.append(DDL_FILE_ENV_KEY)
    
    if missing_vars:
        print("Erro: As seguintes variáveis de ambiente não estão definidas (verifique seu arquivo .env ou o ambiente do sistema):")
        for var in missing_vars:
            print(f"- {var}")
        print("\nPor favor, defina essas variáveis em um arquivo .env na raiz do seu projeto.")
        print("Exemplo de conteúdo para o arquivo .env (localizado em c:\\repos\\projeto-final-engenharia-dados\\.env):")
        print('AZURE_SQL_SERVER_NAME="seu_servidor.database.windows.net"')
        print('AZURE_SQL_DATABASE_NAME="seu_banco_de_dados"')
        print('AZURE_SQL_ADMIN_USER="seu_usuario_admin"')
        print('AZURE_SQL_ADMIN_PASSWORD="sua_senha_segura"')
        print(f'{DDL_FILE_ENV_KEY}="SQL/ER-ddl.sql"  # Caminho do arquivo DDL, relativo à raiz do projeto')
        
        print("\nAlternativamente, exemplo para definir no PowerShell (para a sessão atual):")
        print('$env:AZURE_SQL_SERVER_NAME="seu_servidor.database.windows.net"')
        print('$env:AZURE_SQL_DATABASE_NAME="seu_banco_de_dados"')
        print('$env:AZURE_SQL_ADMIN_USER="seu_usuario_admin"')
        print('$env:AZURE_SQL_ADMIN_PASSWORD="sua_senha_segura"')
        print(f'$env:{DDL_FILE_ENV_KEY}="SQL/ER-ddl.sql"')
        return False
    return True

def read_ddl_from_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        print(f"Erro: Arquivo DDL não encontrado em {file_path}")
        return None
    except Exception as e:
        print(f"Erro ao ler o arquivo DDL {file_path}: {e}")
        return None

def execute_ddl(conn_str, ddl_script_content):
    if not ddl_script_content:
        print("Nenhum conteúdo DDL para executar.")
        return False
    try:
        with pyodbc.connect(conn_str) as conn:
            with conn.cursor() as cursor:
                batches = ddl_script_content.split('GO')
                batches = [b.strip() for b in batches if b.strip() and not b.strip().startswith('--')]

                print("Executando DDL...")
                for i, batch in enumerate(batches):
                    if batch: 
                        print(f"  Executando lote {i+1}/{len(batches)}...")
                        cursor.execute(batch)
                conn.commit()
                print("DDL executado com sucesso!")
    except pyodbc.Error as ex:
        sqlstate = ex.args[0]
        print(f"Erro ao conectar ou executar DDL: {sqlstate}")
        print(ex)
        return False
    return True

def import_csv_data(conn_str, table_name, csv_file_path, column_mapping):
    print(f"\n--- Importação de CSV para a tabela {table_name} ---")
    print(f"Arquivo CSV: {csv_file_path}")
    print(f"Mapeamento de colunas: {column_mapping}")
    pass

def main():
    if not check_db_variables():
        return

    PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    resolved_ddl_file_path = os.path.join(PROJECT_ROOT, DDL_FILE_PATH_FROM_ENV)

    ddl_content = read_ddl_from_file(resolved_ddl_file_path) # Caminho do DDL agora resolvido
    if not ddl_content:
        print(f"Não foi possível ler o DDL do arquivo: {resolved_ddl_file_path}. Verifique o caminho no .env e a existência do arquivo. Abortando.")
        return

    conn_str = (
        f"DRIVER={{ODBC Driver 17 for SQL Server}};"
        f"SERVER={DB_SERVER};" 
        f"DATABASE={DB_NAME};" 
        f"UID={DB_USER};"     
        f"PWD={DB_PASSWORD};"  
        f"Encrypt=yes;"
        f"TrustServerCertificate=no;"
        f"Connection Timeout=30;"
    )

    print("Iniciando configuração do banco de dados...")

    if execute_ddl(conn_str, ddl_content):
        print("Criação de tabelas concluída.")
        # --- Seção para importação de CSV ---

        print("\nConfiguração do banco de dados e importação concluídas.")
    else:
        print("Falha na configuração do banco de dados.")

if __name__ == "__main__":
    main()
