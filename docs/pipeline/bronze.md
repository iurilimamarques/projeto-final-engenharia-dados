# Camada Bronze

A camada Bronze realiza a leitura dos arquivos da Landing e os transforma em tabelas Delta.


## Mostrando todos os arquivos da camada landing-zone
```python 
display(dbutils.fs.ls(f"/mnt/{storageAccountName}/landing-zone"))
```

## Gerando um dataframe para cada arquivo a partir dos arquivos CSV gravado no container landing-zone do Azure Data Lake Storage
```python 
df_circuits = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/circuits.csv")
df_constructor_results   = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/constructor_results.csv")
df_constructor_standings = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/constructor_standings.csv")
df_constructors     = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/constructors.csv")
df_driver_standings = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/driver_standings.csv")
df_drivers    = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/drivers.csv")
df_lap_times  = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/lap_times.csv")
df_pit_stops  = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/pit_stops.csv")
df_qualifying = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/qualifying.csv")
df_races   = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/races.csv")
df_results = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/results.csv")
df_seasons = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/seasons.csv")
df_sprint_results = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/sprint_results.csv")
df_status  = spark.read.option("infeschema", "true").option("header", "true").csv(f"/mnt/{storageAccountName}/landing-zone/status.csv")
```

## Adicionando metadados de data e hora de processamento e nome do arquivo de origem
```python 
from pyspark.sql.functions import current_timestamp, lit

df_circuits = df_circuits.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("circuits.csv"))
df_constructor_results   = df_constructor_results.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("constructor_results.csv"))
df_constructor_standings = df_constructor_standings.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("constructor_standings.csv"))
df_constructors  = df_constructors.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("constructors.csv"))
df_driver_standings = df_driver_standings.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("driver_standings.csv"))
df_drivers       = df_drivers.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("drivers.csv"))
df_lap_times     = df_lap_times.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("lap_times.csv"))
df_pit_stops     = df_pit_stops.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("pit_stops.csv"))
df_qualifying    = df_qualifying.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("qualifying.csv"))
df_races         = df_races.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("races.csv"))
df_results       = df_results.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("results.csv"))
df_seasons       = df_seasons.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("seasons.csv"))
df_sprint_results = df_sprint_results.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("sprint_results.csv"))
df_status        = df_status.withColumn("data_hora_bronze", current_timestamp()).withColumn("nome_arquivo", lit("status.csv"))
```

## Salvando os dataframes em delta lake (formato de arquivo) no data lake (repositorio cloud)
```python 
df_circuits.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/circuits")
df_constructor_results.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/constructor_results")
df_constructor_standings.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/constructor_standings")
df_constructors.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/constructors")
df_driver_standings.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/driver_standings")
df_drivers.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/drivers")
df_lap_times.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/lap_times")
df_pit_stops.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/pit_stops")
df_qualifying.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/qualifying")
df_races.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/races")
df_results.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/results")
df_seasons.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/seasons")
df_sprint_results.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/sprint_results")
df_status.write.format('delta').save(f"/mnt/{storageAccountName}/bronze/status")
```
 
## Verificando os dados gravados em delta na camada bronze
```python 
display(dbutils.fs.ls(f"/mnt/{storageAccountName}/bronze/"))
```

 
## Lendo um exemplo de um delta lake para validar a existencia dos dados e das colunas do metadados
```python 
spark.read.format('delta').load(f'/mnt/{storageAccountName}/bronze/drivers').limit(10).display()
```

 