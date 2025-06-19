# Camada Silver

A camada Silver é responsável pela limpeza e padronização dos dados brutos da camada Bronze, garantindo que os dados estejam estruturados de maneira consistente.


## Mostrando todos os arquivos da camada bronze
```python 
display(dbutils.fs.ls(f"/mnt/{storageAccountName}/bronze"))
```

## Gerando um dataframe dos delta lake no container bronze do Azure Data Lake Storage
```python 
exemplo código
```

## Adicionando metadados de data e hora de processamento e nome do arquivo de origem
```python 
exemplo código
```

## Limpeza e padronização dos dados
```python 
exemplo código
```

## Salvando os dataframes em delta lake (formato de arquivo) no data lake (repositorio cloud)
```python 
exemplo código
```

## Verificando os dados gravados em delta na camada silver
```python 
display(dbutils.fs.ls(f"/mnt/{storageAccountName}/silver/"))
```