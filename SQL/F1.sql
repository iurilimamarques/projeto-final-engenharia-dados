CREATE TABLE [drivers] (
  [driverId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [driverRef] varchar(50) NOT NULL,
  [number] integer,
  [code] char(3) NOT NULL,
  [forname] varchar(100) NOT NULL,
  [surname] varchar(100) NOT NULL,
  [dob] date,
  [nationality] varchar(100) NOT NULL,
  [url] varchar(200) NOT NULL
)
GO

CREATE TABLE [circuits] (
  [circuitId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [circuitRef] varchar(100) NOT NULL,
  [name] varchar(100) NOT NULL,
  [location] varchar(100) NOT NULL,
  [country] varchar(100) NOT NULL,
  [lat] integer NOT NULL,
  [lng] integer NOT NULL,
  [alt] integer NOT NULL,
  [url] varchar(200) NOT NULL
)
GO

CREATE TABLE [constructors] (
  [constructorId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [constructorsRef] varchar(100) NOT NULL,
  [name] varchar(100) NOT NULL,
  [nationality] varchar(100) NOT NULL,
  [url] varchar(200) NOT NULL
)
GO

CREATE TABLE [races] (
  [raceId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [year] integer NOT NULL,
  [round] integer NOT NULL,
  [circuitId] integer NOT NULL,
  [name] varchar(100) NOT NULL,
  [date] date,
  [time] time,
  [url] varchar(200) NOT NULL
)
GO

CREATE TABLE [status] (
  [statusId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [status] varchar(100)
)
GO

CREATE TABLE [constructor_results] (
  [constructorResultsId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [raceId] integer NOT NULL,
  [constructorId] integer NOT NULL,
  [points] integer NOT NULL
)
GO

CREATE TABLE [constructor_standings] (
  [constructorStandingsId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [raceId] integer NOT NULL,
  [constructorId] integer NOT NULL,
  [points] integer NOT NULL,
  [position] integer NOT NULL,
  [positionText] integer NOT NULL,
  [wins] integer NOT NULL
)
GO

CREATE TABLE [driver_standings] (
  [driverStandingsId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [raceId] integer NOT NULL,
  [driverId] integer NOT NULL,
  [points] integer NOT NULL,
  [position] integer NOT NULL,
  [positionText] integer NOT NULL,
  [wins] integer NOT NULL
)
GO

CREATE TABLE [lap_times] (
  [raceId] integer NOT NULL,
  [driverId] integer NOT NULL,
  [lap] integer NOT NULL,
  [position] integer NOT NULL,
  [time] time NOT NULL,
  [milliseconds] integer NOT NULL
)
GO

CREATE TABLE [pit_stops] (
  [raceId] integer NOT NULL,
  [driverId] integer NOT NULL,
  [stop] integer NOT NULL,
  [lap] integer NOT NULL,
  [time] time NOT NULL,
  [duration] decimal(6,3) NOT NULL,
  [milliseconds] integer NOT NULL
)
GO

CREATE TABLE [qualifying] (
  [qualifyId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [raceId] integer NOT NULL,
  [driverId] integer NOT NULL,
  [constructorId] integer NOT NULL,
  [number] integer NOT NULL,
  [position] integer NOT NULL,
  [q1] time,
  [q2] time,
  [q3] time
)
GO

CREATE TABLE [results] (
  [resultId] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [raceId] integer NOT NULL,
  [driverId] integer NOT NULL,
  [constructorId] integer NOT NULL,
  [number] integer NOT NULL,
  [grid] integer NOT NULL,
  [position] integer NOT NULL,
  [positionText] integer NOT NULL,
  [positionOrder] integer NOT NULL,
  [time] time,
  [points] integer,
  [laps] integer NOT NULL,
  [milliseconds] integer NOT NULL,
  [fastestLap] integer,
  [rank] integer,
  [statusId] integer NOT NULL,
  [fastestLapTime] time,
  [fastestLapSpeed] integer
)
GO

ALTER TABLE [races] ADD FOREIGN KEY ([circuitId]) REFERENCES [circuits] ([circuitId])
GO

ALTER TABLE [constructor_results] ADD FOREIGN KEY ([raceId]) REFERENCES [races] ([raceId])
GO

ALTER TABLE [constructor_results] ADD FOREIGN KEY ([constructorId]) REFERENCES [constructors] ([constructorId])
GO

ALTER TABLE [constructor_standings] ADD FOREIGN KEY ([raceId]) REFERENCES [races] ([raceId])
GO

ALTER TABLE [constructor_standings] ADD FOREIGN KEY ([constructorId]) REFERENCES [constructors] ([constructorId])
GO

ALTER TABLE [driver_standings] ADD FOREIGN KEY ([raceId]) REFERENCES [races] ([raceId])
GO

ALTER TABLE [driver_standings] ADD FOREIGN KEY ([driverId]) REFERENCES [drivers] ([driverId])
GO

ALTER TABLE [lap_times] ADD FOREIGN KEY ([raceId]) REFERENCES [races] ([raceId])
GO

ALTER TABLE [lap_times] ADD FOREIGN KEY ([driverId]) REFERENCES [drivers] ([driverId])
GO

ALTER TABLE [pit_stops] ADD FOREIGN KEY ([raceId]) REFERENCES [races] ([raceId])
GO

ALTER TABLE [pit_stops] ADD FOREIGN KEY ([driverId]) REFERENCES [drivers] ([driverId])
GO

ALTER TABLE [qualifying] ADD FOREIGN KEY ([raceId]) REFERENCES [races] ([raceId])
GO

ALTER TABLE [qualifying] ADD FOREIGN KEY ([driverId]) REFERENCES [drivers] ([driverId])
GO

ALTER TABLE [qualifying] ADD FOREIGN KEY ([constructorId]) REFERENCES [constructors] ([constructorId])
GO

ALTER TABLE [results] ADD FOREIGN KEY ([raceId]) REFERENCES [races] ([raceId])
GO

ALTER TABLE [results] ADD FOREIGN KEY ([driverId]) REFERENCES [drivers] ([driverId])
GO

ALTER TABLE [results] ADD FOREIGN KEY ([constructorId]) REFERENCES [constructors] ([constructorId])
GO

ALTER TABLE [results] ADD FOREIGN KEY ([statusId]) REFERENCES [status] ([statusId])
GO

ALTER TABLE [drivers] ADD FOREIGN KEY ([number]) REFERENCES [drivers] ([driverId])
GO
