USE THE_X_TEAM
GO

IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Compra_autoparte'
		)
		drop table Compra_autoparte 
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Compra'
		)
		drop table Compra
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Auto'
		)
		drop table Auto
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Tipo_Auto'
		)
		drop table Tipo_Auto

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
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Factura_Autoparte'
		)
		drop table Factura_Autoparte
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Factura'
		)
		drop table Factura
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Cliente'
		)
		drop table Cliente
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Autoparte'
		)
		drop table Autoparte
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Fabricante'
		)
		drop table Fabricante
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Modelo'
		)
		drop table Modelo
IF EXISTS (
		SELECT * 
		FROM sys.tables 
		WHERE object_name(object_id) = 'Sucursal'
		)
		drop table Sucursal

/* FABRICANTES */
CREATE TABLE Fabricante(
"ID_FABRICANTE" int identity(1,1) PRIMARY KEY,
"FABRICANTE_NOMBRE" nvarchar(255)
);

INSERT INTO Fabricante
select DISTINCT FABRICANTE_NOMBRE from GD2C2020.gd_esquema.Maestra;

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
"ID_TRANSMISION" decimal FOREIGN KEY REFERENCES Tipo_Transmision(TIPO_TRANSMISION_CODIGO),
"tipo_motor_codigo" decimal (18,0)
);

insert into Config_Auto
select DISTINCT TIPO_CAJA_CODIGO, TIPO_TRANSMISION_CODIGO,TIPO_MOTOR_CODIGO from GD2C2020.gd_esquema.Maestra
WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL
and TIPO_MOTOR_CODIGO is not null;

-------------------------------------------------------

/* SUCURSAL */
CREATE TABLE Sucursal (
"ID_SUCURSAL" int identity(1,1) PRIMARY KEY,
"SUCURSAL_DIRECCION" nvarchar(255),
"SUCURSAL_MAIL" nvarchar(255) ,
"SUCURSAL_TELEFONO" decimal(18,0),
"SUCURSAL_CIUDAD" nvarchar(255)
);

insert into Sucursal
select DISTINCT SUCURSAL_DIRECCION, SUCURSAL_MAIL,SUCURSAL_TELEFONO,SUCURSAL_CIUDAD from GD2C2020.gd_esquema.Maestra
WHERE SUCURSAL_DIRECCION IS NOT NULL;
------------------------------------------------------------------
/* CLIENTE */
CREATE TABLE Cliente (
"ID_CLIENTE" int identity(1,1) PRIMARY KEY,
"CLIENTE_DNI" decimal(18,0) ,
"CLIENTE_APELLIDO" nvarchar(255),
"CLIENTE_NOMBRE" nvarchar(255) ,
"CLIENTE_DIRECCION" nvarchar(255),
"CLIENTE_FECHA_NAC" datetime2(3),
"CLIENTE_MAIL" nvarchar(255)
);

select CLIENTE_DNI from Cliente
group by CLIENTE_DNI
having count(CLIENTE_DNI) > 1
/* clientes repetidos?
72027361
24793088
35779577
27878674
89095090
23709507
16279501
51888356
81185477
85850168
37638888
9498035
25340741
6119806
93237277
42739188
13814044
93569323
81139763
2697277
23977150
20514527
75067202
42012010
49340011
47875449
26034978
9647031
*/

INSERT INTO Cliente
select distinct CLIENTE_DNI, CLIENTE_APELLIDO, CLIENTE_NOMBRE, CLIENTE_DIRECCION, CLIENTE_FECHA_NAC, CLIENTE_MAIL 
from GD2C2020.gd_esquema.Maestra
where CLIENTE_DNI IS NOT NULL 
group by CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,CLIENTE_FECHA_NAC,CLIENTE_MAIL

INSERT INTO Cliente
select distinct FAC_CLIENTE_DNI, FAC_CLIENTE_APELLIDO, FAC_CLIENTE_NOMBRE, FAC_CLIENTE_DIRECCION, FAC_CLIENTE_FECHA_NAC, FAC_CLIENTE_MAIL 
from GD2C2020.gd_esquema.Maestra
where FAC_CLIENTE_DNI IS NOT NULL 
AND NOT EXISTS (
	SELECT * FROM CLIENTE
	where CLIENTE_DNI = FAC_CLIENTE_DNI AND
	CLIENTE_APELLIDO = FAC_CLIENTE_APELLIDO AND
	CLIENTE_NOMBRE = FAC_CLIENTE_NOMBRE AND
	CLIENTE_DIRECCION = FAC_CLIENTE_DIRECCION AND
	CLIENTE_FECHA_NAC = FAC_CLIENTE_FECHA_NAC AND
	CLIENTE_MAIL = FAC_CLIENTE_MAIL
)
group by FAC_CLIENTE_DNI,FAC_CLIENTE_APELLIDO,FAC_CLIENTE_NOMBRE,FAC_CLIENTE_DIRECCION,FAC_CLIENTE_FECHA_NAC,FAC_CLIENTE_MAIL
------------------------------------------------------------------
/* FACTURA */
CREATE TABLE Factura (
"FACTURA_NRO" decimal(18,0) PRIMARY KEY,
"FACTURA_FECHA" datetime2(3),
"ID_CLIENTE" int FOREIGN KEY REFERENCES Cliente(ID_CLIENTE),
"ID_SUCURSAL" int FOREIGN KEY REFERENCES Sucursal(ID_SUCURSAL) 
--falta crear el AUTO
--"ID_AUTO" int foreign key
);

insert into Factura (FACTURA_NRO,FACTURA_FECHA,ID_CLIENTE,ID_SUCURSAL)
select DISTINCT FACTURA_NRO, FACTURA_FECHA, 
(Select ID_CLIENTE FROM Cliente WHERE CLIENTE_DNI= maestra.FAC_CLIENTE_DNI), 
(Select ID_SUCURSAL FROM Sucursal WHERE SUCURSAL_DIRECCION=maestra.FAC_SUCURSAL_DIRECCION) 
from GD2C2020.gd_esquema.Maestra maestra
WHERE FACTURA_NRO IS NOT NULL;


------------------------------------------------------------------
/* MODELO */

create table Modelo(
"modelo_codigo" decimal(18, 0) primary key,
"modelo_nombre" nvarchar(255),
"modelo_potencia" decimal(18, 0)
);

insert into Modelo
select modelo_codigo,modelo_nombre,modelo_potencia from GD2C2020.gd_esquema.Maestra
group by modelo_codigo,modelo_nombre,modelo_potencia;
------------------------------------------------------------------
/* AUTOPARTE */
CREATE TABLE Autoparte (
"AUTO_PARTE_CODIGO" decimal(18,0) PRIMARY KEY,
"AUTO_PARTE_DESCRIPCION" nvarchar(255) ,
"ID_FABRICANTE" int FOREIGN KEY REFERENCES Fabricante(ID_FABRICANTE),
"ID_MODELO" decimal(18,0) FOREIGN KEY REFERENCES Modelo(MODELO_CODIGO),
"COMPRA_PRECIO" decimal(18,2),
"PRECIO_FACTURADO" decimal(18,2)
);

insert into Autoparte
select DISTINCT maestra.AUTO_PARTE_CODIGO, AUTO_PARTE_DESCRIPCION, fab.id_fabricante, MODELO_CODIGO, t.COMPRA_PRECIO, PRECIO_FACTURADO 
from GD2C2020.gd_esquema.Maestra maestra
inner join Fabricante fab
on fab.fabricante_nombre = maestra.fabricante_nombre
inner join (
	select DISTINCT AUTO_PARTE_CODIGO, COMPRA_PRECIO from GD2C2020.gd_esquema.Maestra maestra
	inner join Fabricante fab on fab.fabricante_nombre = maestra.fabricante_nombre
	WHERE AUTO_PARTE_CODIGO IS NOT NULL 
	AND PRECIO_FACTURADO IS NULL
	) T
on t.AUTO_PARTE_CODIGO = maestra.AUTO_PARTE_CODIGO
WHERE maestra.AUTO_PARTE_CODIGO IS NOT NULL
AND maestra.COMPRA_PRECIO IS NULL
------------------------------------------------------------------
/* FACTURA_AUTOPARTE */
CREATE TABLE Factura_Autoparte (
"ID_CLIENTE" int identity(1,1) PRIMARY KEY,
"CLIENTE_DNI" decimal(18,0),
"CLIENTE_APELLIDO" nvarchar(255),
"CLIENTE_NOMBRE" nvarchar(255) ,
"CLIENTE_DIRECCION" nvarchar(255),
"CLIENTE_FECHA_NAC" datetime2(3),
"CLIENTE_MAIL" nvarchar(255)
);
------------------------------------------------------------------
/* TIPO_AUTO */

create table Tipo_Auto (
"tipo_auto_codigo" decimal(18,0) primary key,
"tipo_auto_desc" nvarchar(255)
);

INSERT INTO Tipo_Auto
select tipo_auto_codigo,tipo_auto_desc from GD2C2020.gd_esquema.Maestra
where TIPO_AUTO_CODIGO is not null
group by tipo_auto_codigo,tipo_auto_desc;
---------------------------------------------------------
/* AUTO */
create table Auto (
"id_auto" int identity(1,1) primary key,
"auto_patente" nvarchar(50),
"auto_nro_chasis" nvarchar(50),
"auto_nro_motor" nvarchar(50),
"auto_fecha_alta" datetime2(3),
"auto_cant_kms" decimal(18),
"id_fabricante" int foreign key references Fabricante(id_fabricante),
"id_modelo" decimal(18,0) foreign key references Modelo(modelo_codigo),
"tipo_auto" decimal(18,0) foreign key references Tipo_auto(tipo_auto_codigo),
"precio_facturado" decimal(18,2),
"compra_precio" decimal(18,2),
"id_config" int foreign key references Config_Auto("id_config")
);

insert into Auto
select auto_patente,
auto_nro_chasis,
auto_nro_motor,
auto_fecha_alta,
auto_cant_kms,
(select id_fabricante from Fabricante where maestra.FABRICANTE_NOMBRE = Fabricante.FABRICANTE_NOMBRE) as idFab,
(select MODELO_CODIGO from Modelo where maestra.MODELO_CODIGO = Modelo.MODELO_CODIGO) as idModelo,
(select TIPO_AUTO_CODIGO from tipo_auto where maestra.TIPO_AUTO_CODIGO = tipo_auto.tipo_auto_codigo) as tipoAuto,
precio_facturado,
compra_precio,
ca.id_config from GD2C2020.gd_esquema.Maestra maestra
inner join config_auto ca
on ca.ID_CAJA = maestra.TIPO_CAJA_CODIGO
and ca.id_transmision = maestra.TIPO_TRANSMISION_CODIGO
and ca.tipo_motor_codigo = maestra.TIPO_MOTOR_CODIGO
------------------------------------------------------------------
/* COMPRA */
CREATE TABLE Compra (
"COMPRA_NRO" decimal(18,0) PRIMARY KEY,
"COMPRA_FECHA" datetime2(3) ,
--"ID_CLIENTE" int FOREIGN KEY REFERENCES Cliente(ID_CLIENTE),
"ID_SUCURSAL" int FOREIGN KEY REFERENCES Sucursal(ID_SUCURSAL), 
"id_auto" int FOREIGN KEY REFERENCES AUTO(id_auto) 
);

/* COMPRA --TERMINAR-- AUTOPARTE */
CREATE TABLE Compra_Autoparte (
"COMPRA_NRO" decimal(18,0) PRIMARY KEY,
"COMPRA_FECHA" datetime2(3) ,
--"ID_CLIENTE" int FOREIGN KEY REFERENCES Cliente(ID_CLIENTE),
"ID_SUCURSAL" int FOREIGN KEY REFERENCES Sucursal(ID_SUCURSAL), 
--falta crear el AUTO
"id_auto" int FOREIGN KEY REFERENCES AUTO(id_auto) 
);
