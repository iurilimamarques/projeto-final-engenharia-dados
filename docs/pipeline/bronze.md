# Camada Bronze

A camada Bronze realiza a leitura dos arquivos da Landing e os transforma em tabelas Delta.


## Mostrando todos os arquivos da camada landing-zone
```python 
display(dbutils.fs.ls(f"/mnt/{storageAccountName}/landing-zone"))
```

## Gerando um dataframe para cada arquivo a partir dos arquivos CSV gravado no container landing-zone do Azure Data Lake Storage
```python 
exemplo código
```

## Adicionando metadados de data e hora de processamento e nome do arquivo de origem
```python 
exemplo código
```

## Salvando os dataframes em delta lake (formato de arquivo) no data lake (repositorio cloud)
```python 
exemplo código
```
 
## Verificando os dados gravados em delta na camada bronze
```python 
exemplo código
```

 
## Lendo um exemplo de um delta lake para validar a existencia dos dados e das colunas do metadados
```python 
exemplo código
```

 