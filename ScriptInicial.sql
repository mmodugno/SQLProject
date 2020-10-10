/*****CREAR DATABASE Y DESPUÉS CREAR SCHEMA*********/
USE THE_X_TEAM
GO

IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Fabricante'
		)
		drop table Fabricante
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Config_Auto'
		)
		drop table Config_Auto
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Tipo_Caja'
		)
		drop table Tipo_Caja
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Tipo_Transmision'
		)
		drop table Tipo_Transmision

/* FABRICANTES */
CREATE TABLE Fabricante(
"ID_FABRICANTE" int identity(1,1) PRIMARY KEY,
"FABRICANTE_NOMBRE" nvarchar(255)
);

INSERT INTO Fabricante
select DISTINCT FABRICANTE_NOMBRE from GD2C2020.gd_esquema.Maestra

-------------------------------------------------------

/* TIPO_CAJA */
CREATE TABLE Tipo_Caja (
"TIPO_CAJA_CODIGO" decimal(18, 0) PRIMARY KEY,
"TIPO_CAJA_DESC" nvarchar(255)
);

INSERT INTO Tipo_Caja
select DISTINCT TIPO_CAJA_CODIGO,TIPO_CAJA_DESC from GD2C2020.gd_esquema.Maestra
where TIPO_CAJA_CODIGO is not null;

-------------------------------------------------------

/* TIPO_TRANSMISION */
CREATE TABLE Tipo_Transmision (
"TIPO_TRANSMISION_CODIGO" decimal(18, 0) PRIMARY KEY,
"TIPO_TRANSMISION_DESC" nvarchar(255)
);

INSERT INTO Tipo_Transmision
select DISTINCT TIPO_TRANSMISION_CODIGO,TIPO_TRANSMISION_DESC from GD2C2020.gd_esquema.Maestra
where TIPO_TRANSMISION_CODIGO is not null;

-------------------------------------------------------

/* TIPO_MOTOR 
CREATE TABLE Tipo_Motor (
"TIPO_MOTOR_CODIGO" decimal(18, 0) PRIMARY KEY,
"TIPO_MOTOR_DESC" nvarchar(255)
);

INSERT INTO Tipo_Motor
select DISTINCT TIPO_MOTOR_CODIGO from GD2C2020.gd_esquema.Maestra
where TIPO_MOTOR_CODIGO is not null;*/

/* CONFIG_AUTO */
CREATE TABLE Config_Auto (
"ID_CONFIG" int identity(1,1) PRIMARY KEY,
"ID_CAJA" decimal FOREIGN KEY REFERENCES Tipo_Caja(TIPO_CAJA_CODIGO),
"ID_TRANSMISION" decimal FOREIGN KEY REFERENCES Tipo_Transmision(TIPO_TRANSMISION_CODIGO)
);

insert into Config_Auto
select DISTINCT TIPO_CAJA_CODIGO, TIPO_TRANSMISION_CODIGO from GD2C2020.gd_esquema.Maestra
WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL;