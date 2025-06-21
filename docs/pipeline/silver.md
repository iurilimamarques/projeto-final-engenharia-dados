# Camada Silver

A camada Silver é responsável pela limpeza e padronização dos dados brutos da camada Bronze, garantindo que os dados estejam estruturados de maneira consistente.


## Mostrando todos os arquivos da camada bronze
```python 
display(dbutils.fs.ls(f"/mnt/{storageAccountName}/bronze"))
```

## Gerando um dataframe dos delta lake no container bronze do Azure Data Lake Storage
```python 
df_circuits   = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/circuits")
df_constructor_results     = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/constructor_results")
df_constructor_standings   = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/constructor_standings")
df_constructors  = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/constructors")
df_driver_standings    = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/driver_standings")
df_drivers     = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/drivers")
df_lap_times     = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/lap_times")
df_pit_stops    = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/pit_stops")
df_qualifying = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/qualifying")
df_races    = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/races")
df_results  = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/results")
df_seasons  = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/seasons")
df_sprint_results  = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/sprint_results")
df_status  = spark.read.format('delta').load(f"/mnt/{storageAccountName}/bronze/status")
```

## Adicionando metadados de data e hora de processamento e nome do arquivo de origem
```python 
from pyspark.sql.functions import current_timestamp, lit

df_circuits = df_circuits.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("circuits"))
df_constructor_results   = df_constructor_results.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("constructor_results"))
df_constructor_standings = df_constructor_standings.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("constructor_standings"))
df_constructors  = df_constructors.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("constructors"))
df_driver_standings = df_driver_standings.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("driver_standings"))
df_drivers       = df_drivers.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("drivers"))
df_lap_times     = df_lap_times.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("lap_times"))
df_pit_stops     = df_pit_stops.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("pit_stops"))
df_qualifying    = df_qualifying.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("qualifying"))
df_races         = df_races.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("races"))
df_results       = df_results.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("results"))
df_seasons       = df_seasons.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("seasons"))
df_sprint_results = df_sprint_results.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("sprint_results"))
df_status        = df_status.withColumn("data_hora_silver", current_timestamp()).withColumn("nome_arquivo", lit("status"))
```

## Limpeza e padronização dos dados
```python 
# Mudando o nome das colunas para maiúscula e ajustanto os nomes das colunas de acordo com o dicionario de dados

#['circuitId', 'circuitRef', 'name', 'location', 'country', 'lat', 'lng', 'alt', 'url', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver'] 
df_circuits = ( df_circuits 
               .withColumnRenamed("circuitId" , "IDENTIFIER_CIRCUIT")
               .withColumnRenamed("circuitRef" , "REFERENCE_CIRCUIT")
               .withColumnRenamed("name" , "NAME")
               .withColumnRenamed("location" , "LOCATION")
               .withColumnRenamed("country" , "COUNTRY" )
               .withColumnRenamed("lat" , "LATITUDE" )
               .withColumnRenamed("lng" , "LONGITUDE" )
               .withColumnRenamed("alt" , "ALTITUDE" )
               .withColumnRenamed("url" , "URL" )
               .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
               .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
               .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
               )
#['constructorResultsId', 'raceId', 'constructorId', 'points', 'status', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver'] 
df_constructor_results = ( df_constructor_results 
                          .withColumnRenamed("constructorResultsId" , "IDENTIFIER_CONSTRUCTOR_RESULTS")
                          .withColumnRenamed("raceId" , "IDENTIFIER_RACE")
                          .withColumnRenamed("constructorId" , "IDENTIFIER_CONSTRUCTOR")
                          .withColumnRenamed("points" , "POINTS")
                          .withColumnRenamed("status" , "STATUS")
                          .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
                          .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
                          .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
                          )
#['constructorStandingsId', 'raceId', 'constructorId', 'points', 'position', 'positionText', 'wins', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver']
df_constructor_standings = ( df_constructor_standings 
                            .withColumnRenamed("constructorStandingsId" , "IDENTIFIER_CONSTRUCTOR_STANDINGS")
                            .withColumnRenamed("raceId" , "IDENTIFIER_RACE")
                            .withColumnRenamed("constructorId" , "IDENTIFIER_CONSTRUCTOR")
                            .withColumnRenamed("position" , "POSITION")
                            .withColumnRenamed("positionText" , "POSITION_TEXT")
                            .withColumnRenamed("wins" , "WINS")
                            .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
                            .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
                            .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
                            )
#['constructorId', 'constructorRef', 'name', 'nationality', 'url', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver'] 
df_constructors = ( df_constructors     
                   .withColumnRenamed("constructorId" , "IDENTIFIER_CONSTRUCTOR")
                   .withColumnRenamed("constructorRef" , "REFERENCE_CONSTRUCTOR")
                   .withColumnRenamed("name" , "NAME")
                   .withColumnRenamed("nationality" , "NATIONALITY")
                   .withColumnRenamed("url" , "URL")
                   .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
                   .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
                   .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
                   )
#['driverStandingsId', 'raceId', 'driverId', 'points', 'position', 'positionText', 'wins', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver'] 
df_driver_standings = ( df_driver_standings 
                       .withColumnRenamed("driverStandingsId" , "IDENTIFIER_DRIVER_STANDINGS")
                       .withColumnRenamed("raceId" , "IDENTIFIER_RACE")
                       .withColumnRenamed("driverId" , "IDENTIFIER_DRIVER")
                       .withColumnRenamed("points" , "POINTS")
                       .withColumnRenamed("position" , "POSITION")
                       .withColumnRenamed("positionText" , "POSITION_TEXT")
                       .withColumnRenamed("wins" , "WINS")
                       .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
                       .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
                       .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
                       )
#['driverId', 'driverRef', 'number', 'code', 'forename', 'surname', 'dob', 'nationality', 'url', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver'] 
df_drivers = ( df_drivers 
              .withColumnRenamed("driverId" , "IDENTIFIER_DRIVER")
              .withColumnRenamed("driverRef" , "REFERENCE_DRIVER")
              .withColumnRenamed("number" , "NUMBER")
              .withColumnRenamed("code" , "CODE")
              .withColumnRenamed("forename" , "FORENAME")
              .withColumnRenamed("surname" , "SURNAME")
              .withColumnRenamed("dob" , "DOB")
              .withColumnRenamed("nationality" , "NATIONALITY")
              .withColumnRenamed("url" , "URL")
              .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
              .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
              .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
              )
#['raceId', 'driverId', 'lap', 'position', 'time', 'milliseconds', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver']            
df_lap_times = ( df_lap_times 
                .withColumnRenamed("RACEID" , "IDENTIFIER_RACE")
                .withColumnRenamed("driverId" , "IDENTIFIER_DRIVER")
                .withColumnRenamed("lap" , "LAP")
                .withColumnRenamed("position" , "POSITION")
                .withColumnRenamed("time" , "TIME")
                .withColumnRenamed("milliseconds" , "MILLISECONDS")
                .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
                .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
                .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
                )
#['raceId', 'driverId', 'stop', 'lap', 'time', 'duration', 'milliseconds', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver']             
df_pit_stops = ( df_pit_stops
                .withColumnRenamed("raceId" , "IDENTIFIER_RACE")
                .withColumnRenamed("driverId" , "IDENTIFIER_DRIVER")
                .withColumnRenamed("stop" , "STOP")
                .withColumnRenamed("lap" , "LAP")
                .withColumnRenamed("time" , "TIME")
                .withColumnRenamed("duration" , "DURATION")
                .withColumnRenamed("milliseconds" , "MILLISECONDS")
                .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
                .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
                .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
                )
#['qualifyId', 'raceId', 'driverId', 'constructorId', 'number', 'position', 'q1', 'q2', 'q3', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver'] 
df_qualifying = ( df_qualifying 
                 .withColumnRenamed("qualifyId" , "IDENTIFIER_QUALIFYING")
                 .withColumnRenamed("raceId" , "IDENTIFIER_RACE")
                 .withColumnRenamed("driverId" , "IDENTIFIER_DRIVER")
                 .withColumnRenamed("constructorId" , "IDENTIFIER_CONSTRUCTOR")
                 .withColumnRenamed("number" , "NUMBER")
                 .withColumnRenamed("position" , "POSITION")
                 .withColumnRenamed("q1" , "Q1")
                 .withColumnRenamed("q2" , "Q2")
                 .withColumnRenamed("q3" , "Q3")
                 .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
                 .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
                 .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
                 )
#['raceId', 'year', 'round', 'circuitId', 'name', 'date', 'time', 'url', 'fp1_date', 'fp1_time', 'fp2_date', 'fp2_time', 'fp3_date', 'fp3_time', 'quali_date', 'quali_time', 'sprint_date', 'sprint_time', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver'] 
df_races = ( df_races 
            .withColumnRenamed("RACEID" , "IDENTIFIER_RACE")
            .withColumnRenamed("year" , "YEAR")
            .withColumnRenamed("round" , "ROUND")
            .withColumnRenamed("circuitId" , "IDENTIFIER_CIRCUIT")
            .withColumnRenamed("name" , "NAME")
            .withColumnRenamed("date" , "DATE")
            .withColumnRenamed("time" , "TIME")
            .withColumnRenamed("url" , "URL")
            .withColumnRenamed("fp1_date" , "FP1_DATE")
            .withColumnRenamed("fp1_time" , "FP1_TIME")
            .withColumnRenamed("fp2_date" , "FP2_DATE")
            .withColumnRenamed("fp2_time" , "FP2_TIME")
            .withColumnRenamed("fp3_date" , "FP3_DATE")
            .withColumnRenamed("fp3_time" , "FP3_TIME")
            .withColumnRenamed("quali_date" , "QUALI_DATE")
            .withColumnRenamed("quali_time" , "QUALI_TIME")
            .withColumnRenamed("sprint_date" , "SPRINT_DATE")
            .withColumnRenamed("sprint_time" , "SPRINT_TIME")
            .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
            .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
            .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
            )
#['resultId', 'raceId', 'driverId', 'constructorId', 'number', 'grid', 'position', 'positionText', 'positionOrder', 'points', 'laps', 'time', 'milliseconds', 'fastestLap', 'rank', 'fastestLapTime', 'fastestLapSpeed', 'statusId', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver'] 
df_results = ( df_results 
              .withColumnRenamed("resultId" , "IDENTIFIER_RESULT")
              .withColumnRenamed("raceId" , "IDENTIFIER_RACE")
              .withColumnRenamed("driverId" , "IDENTIFIER_DRIVER")
              .withColumnRenamed("constructorId" , "IDENTIFIER_CONSTRUCTOR")
              .withColumnRenamed("number" , "NUMBER")
              .withColumnRenamed("grid" , "GRID")
              .withColumnRenamed("position" , "POSITION")
              .withColumnRenamed("positionText" , "POSITION_TEXT")
              .withColumnRenamed("positionOrder" , "POSITION_ORDER")
              .withColumnRenamed("points" , "POINTS")
              .withColumnRenamed("laps" , "LAPS")
              .withColumnRenamed("time" , "TIME")
              .withColumnRenamed("milliseconds" , "MILLISECONDS")
              .withColumnRenamed("fastestLap" , "FASTESTLAP")
              .withColumnRenamed("rank" , "RANK")
              .withColumnRenamed("fastestLapTime" , "FASTESTLAPTIME")
              .withColumnRenamed("fastestLapSpeed" , "FASTESTLAPSPEED")
              .withColumnRenamed("statusId" , "IDENTIFIER_STATUS")
              .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
              .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
              .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
              )
#['year', 'url', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver']               
df_seasons = (df_seasons 
              .withColumnRenamed("year" , "YEAR")
              .withColumnRenamed("url" , "URL")
              .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
              .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
              .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER")
              )
#['resultId', 'raceId', 'driverId', 'constructorId', 'number', 'grid', 'position', 'positionText', 'positionOrder', 'points', 'laps', 'time', 'milliseconds', 'fastestLap', 'fastestLapTime', 'statusId', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver'] 
df_sprint_results = ( df_sprint_results
                     .withColumnRenamed("resultId" , "IDENTIFIER_RESULT")
                     .withColumnRenamed("raceId" , "IDENTIFIER_RACE")
                     .withColumnRenamed("driverId" , "IDENTIFIER_DRIVER")
                     .withColumnRenamed("constructorId" , "IDENTIFIER_CONSTRUCTOR")
                     .withColumnRenamed("number" , "NUMBER")
                     .withColumnRenamed("grid" , "GRID")
                     .withColumnRenamed("position" , "POSITION")
                     .withColumnRenamed("positionText" , "POSITION_TEXT")
                     .withColumnRenamed("positionOrder" , "POSITION_ORDER")
                     .withColumnRenamed("points" , "POINTS")
                     .withColumnRenamed("laps" , "LAPS")
                     .withColumnRenamed("time" , "TIME")
                     .withColumnRenamed("milliseconds" , "MILLISECONDS")
                     .withColumnRenamed("fastestLap" , "FASTESTLAP")
                     .withColumnRenamed("fastestLapTime" , "FASTESTLAPTIME")
                     .withColumnRenamed("statusId" , "IDENTIFIER_STATUS")
                     .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
                     .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
                     .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER")
                     )
#['statusId', 'status', 'data_hora_bronze', 'nome_arquivo', 'data_hora_silver']
df_status = ( df_status
            .withColumnRenamed("statusId" , "IDENTIFIER_STATUS")
            .withColumnRenamed("status" , "STATUS")
            .withColumnRenamed("data_hora_bronze", "DATA_HORA_BRONZE") 
            .withColumnRenamed("nome_arquivo" , "NOME_ARQUIVO") 
            .withColumnRenamed("data_hora_silver" , "DATA_HORA_SILVER") 
            )
```

## Salvando os dataframes em delta lake (formato de arquivo) no data lake (repositorio cloud)
```python 
df_circuits.write.format('delta').save(f"/mnt/{storageAccountName}/silver/circuits")
df_constructor_results.write.format('delta').save(f"/mnt/{storageAccountName}/silver/constructor_results")
df_constructor_standings.write.format('delta').save(f"/mnt/{storageAccountName}/silver/constructor_standings")
df_constructors.write.format('delta').save(f"/mnt/{storageAccountName}/silver/constructors")
df_driver_standings.write.format('delta').save(f"/mnt/{storageAccountName}/silver/driver_standings")
df_drivers.write.format('delta').save(f"/mnt/{storageAccountName}/silver/drivers")
df_lap_times.write.format('delta').save(f"/mnt/{storageAccountName}/silver/lap_times")
df_pit_stops.write.format('delta').save(f"/mnt/{storageAccountName}/silver/pit_stops")
df_qualifying.write.format('delta').save(f"/mnt/{storageAccountName}/silver/qualifying")
df_races.write.format('delta').save(f"/mnt/{storageAccountName}/silver/races")
df_results.write.format('delta').save(f"/mnt/{storageAccountName}/silver/results")
df_seasons.write.format('delta').save(f"/mnt/{storageAccountName}/silver/seasons")
df_sprint_results.write.format('delta').save(f"/mnt/{storageAccountName}/silver/sprint_results")
df_status.write.format('delta').save(f"/mnt/{storageAccountName}/silver/status")
```

## Verificando os dados gravados em delta na camada silver
```python 
display(dbutils.fs.ls(f"/mnt/{storageAccountName}/silver/"))
```