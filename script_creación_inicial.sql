use GD2C2020
go

If EXISTS (
	select * from sys.schemas
	where name = 'THE_X_TEAM'
)
BEGIN

/*
Primero, borramos todos los datos(tablas,base,vistas,etc) que ya existan, para evitar inconvenientes a la hora de volver a ejecutar el script completo
*/

--Tablas
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Factura_Autoparte'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Factura_Autoparte
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Compra_autoparte'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Compra_autoparte 
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Compra'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Compra

	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Factura'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Factura
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Auto'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Auto
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Tipo_Auto'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Tipo_Auto
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Autoparte'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Autoparte
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Modelo'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Modelo
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Cliente'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Cliente
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Sucursal'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Sucursal
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Config_Auto'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Config_Auto
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Tipo_Transmision'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Tipo_Transmision
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Tipo_Caja'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Tipo_Caja
	IF EXISTS (
			SELECT * 
			FROM sys.tables 
			WHERE object_name(object_id) = 'Fabricante'
			AND schema_name(schema_id) = 'THE_X_TEAM'
			)
			drop table THE_X_TEAM.Fabricante
END

ELSE

BEGIN

	EXEC ('create schema THE_X_TEAM;')

	PRINT 'Creado schema THE_X_TEAM'
END

GO


-- BORRADO DE VISTAS

IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'CompraAutomoviles'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.CompraAutomoviles
GO

IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'CompraAutopartes'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.CompraAutopartes
GO

IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'FacturacionAutomoviles'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.FacturacionAutomoviles
GO

IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'FacturacionAutopartes'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.FacturacionAutopartes
GO

/**********************************************
----------   CREACION DE TABLAS    ------------
**********************************************/

/* FABRICANTES */

USE GD2C2020
GO

CREATE TABLE THE_X_TEAM.Fabricante(
"ID_FABRICANTE" int identity(1,1) PRIMARY KEY,
"FABRICANTE_NOMBRE" nvarchar(255)
);

/* TIPO_CAJA */
CREATE TABLE THE_X_TEAM.Tipo_Caja (
"TIPO_CAJA_CODIGO" decimal(18, 0) PRIMARY KEY,
"TIPO_CAJA_DESC" nvarchar(255)
);

/* TIPO_TRANSMISION */
CREATE TABLE THE_X_TEAM.Tipo_Transmision (
"TIPO_TRANSMISION_CODIGO" decimal(18, 0) PRIMARY KEY,
"TIPO_TRANSMISION_DESC" nvarchar(255)
);

/* CONFIG_AUTO */
CREATE TABLE THE_X_TEAM.Config_Auto (
"ID_CONFIG" int identity(1,1) PRIMARY KEY,
"ID_CAJA" decimal FOREIGN KEY REFERENCES THE_X_TEAM.Tipo_Caja(TIPO_CAJA_CODIGO),
"ID_TRANSMISION" decimal FOREIGN KEY REFERENCES THE_X_TEAM.Tipo_Transmision(TIPO_TRANSMISION_CODIGO),
"tipo_motor_codigo" decimal (18,0)
);

/* SUCURSAL */
CREATE TABLE THE_X_TEAM.Sucursal (
"ID_SUCURSAL" int identity(1,1) PRIMARY KEY,
"SUCURSAL_DIRECCION" nvarchar(255),
"SUCURSAL_MAIL" nvarchar(255) ,
"SUCURSAL_TELEFONO" decimal(18,0),
"SUCURSAL_CIUDAD" nvarchar(255)
);

/* CLIENTE */
CREATE TABLE THE_X_TEAM.Cliente (
"ID_CLIENTE" int identity(1,1) PRIMARY KEY,
"CLIENTE_DNI" decimal(18,0) ,
"CLIENTE_APELLIDO" nvarchar(255),
"CLIENTE_NOMBRE" nvarchar(255) ,
"CLIENTE_DIRECCION" nvarchar(255),
"CLIENTE_FECHA_NAC" datetime2(3),
"CLIENTE_MAIL" nvarchar(255)
);

/* MODELO */
create table THE_X_TEAM.Modelo(
"modelo_codigo" decimal(18, 0) primary key,
"modelo_nombre" nvarchar(255),
"modelo_potencia" decimal(18, 0)
);

/* AUTOPARTE */
CREATE TABLE THE_X_TEAM.Autoparte (
"AUTO_PARTE_CODIGO" decimal(18,0) PRIMARY KEY,
"AUTO_PARTE_DESCRIPCION" nvarchar(255) ,
"ID_FABRICANTE" int FOREIGN KEY REFERENCES THE_X_TEAM.Fabricante(ID_FABRICANTE),
"ID_MODELO" decimal(18,0) FOREIGN KEY REFERENCES THE_X_TEAM.Modelo(MODELO_CODIGO),
"COMPRA_PRECIO" decimal(18,2),
"PRECIO_FACTURADO" decimal(18,2)
);

/* TIPO_AUTO */
create table THE_X_TEAM.Tipo_Auto (
"tipo_auto_codigo" decimal(18,0) primary key,
"tipo_auto_desc" nvarchar(255)
);

/* AUTO */
create table THE_X_TEAM.Auto (
"id_auto" int identity(1,1) primary key,
"auto_patente" nvarchar(50),
"auto_nro_chasis" nvarchar(50),
"auto_nro_motor" nvarchar(50),
"auto_fecha_alta" datetime2(3),
"auto_cant_kms" decimal(18),
"id_fabricante" int foreign key references THE_X_TEAM.Fabricante(id_fabricante),
"id_modelo" decimal(18,0) foreign key references THE_X_TEAM.Modelo(modelo_codigo),
"tipo_auto" decimal(18,0) foreign key references THE_X_TEAM.Tipo_auto(tipo_auto_codigo),
"precio_facturado" decimal(18,2),
"compra_precio" decimal(18,2),
"id_config" int foreign key references THE_X_TEAM.Config_Auto("id_config")
);

/* COMPRA */
CREATE TABLE THE_X_TEAM.Compra (
"COMPRA_NRO" decimal(18,0) PRIMARY KEY,
"COMPRA_FECHA" datetime2(3) ,
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.Cliente(ID_CLIENTE),
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.Sucursal(ID_SUCURSAL), 
"id_auto" int FOREIGN KEY REFERENCES THE_X_TEAM.AUTO(id_auto) 
);

/* FACTURA */
CREATE TABLE THE_X_TEAM.Factura (
"FACTURA_NRO" decimal(18,0) PRIMARY KEY,
"FACTURA_FECHA" datetime2(3),
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.Cliente(ID_CLIENTE),
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.Sucursal(ID_SUCURSAL),
"ID_AUTO" int FOREIGN KEY REFERENCES THE_X_TEAM.AUTO(id_auto) 
);

/* COMPRA AUTOPARTE */
CREATE TABLE THE_X_TEAM.Compra_Autoparte (
"ID_COMP_AUTO_PARTE" int identity(1,1) PRIMARY KEY,
"AUTO_PARTE_CODIGO" decimal(18,0) FOREIGN KEY REFERENCES THE_X_TEAM.Autoparte(AUTO_PARTE_CODIGO),
"COMPRA_NRO" decimal(18,0) FOREIGN KEY REFERENCES THE_X_TEAM.Compra(COMPRA_NRO),
"CANTIDAD_AUTOPARTE" decimal(18,0)
);

/* FACTURA_AUTOPARTE */
CREATE TABLE THE_X_TEAM.Factura_Autoparte (
"ID_FACT_AUTO_PARTE" int identity(1,1) PRIMARY KEY,
"AUTO_PARTE_CODIGO" decimal(18,0) FOREIGN KEY REFERENCES THE_X_TEAM.Autoparte(AUTO_PARTE_CODIGO),
"ID_FACTURA" decimal(18,0) FOREIGN KEY REFERENCES THE_X_TEAM.Factura(FACTURA_NRO),
"CANTIDAD_AUTOPARTE" decimal(18,0)
);

GO

/**********************************************
---------------    VISTAS   -------------------
**********************************************/
--COMPRA DE AUTO
CREATE VIEW THE_X_TEAM.CompraAutomoviles AS
SELECT SUCURSAL_DIRECCION as 'Sucursal',
auto_nro_chasis as 'Nro de chasis',
auto_nro_motor as 'Nro de motor',
auto_patente as 'Patente',
CAST(auto_fecha_alta AS DATE) as 'Fecha de Alta', 
auto_cant_kms as 'Cantidad de kilometraje',
modelo_nombre as 'Modelo',
COMPRA_NRO, 
CAST(COMPRA_FECHA AS DATE) as 'Fecha de Compra',
compra_precio as 'Precio del automovil'
from THE_X_TEAM.Compra c
INNER JOIN THE_X_TEAM.Auto a ON c.id_auto = a.id_auto
INNER JOIN THE_X_TEAM.Modelo modelo ON a.id_modelo = modelo_codigo
INNER JOIN THE_X_TEAM.Sucursal sucur ON sucur.ID_SUCURSAL = c.ID_SUCURSAL
GO


--COMPRA DE AUTOPARTE
CREATE VIEW THE_X_TEAM.CompraAutopartes as
SELECT comp_auto.AUTO_PARTE_CODIGO as 'Codigo de auto parte',
autoparte.AUTO_PARTE_DESCRIPCION as 'Rubro',
modelo_nombre as 'Modelo de automovil',
FABRICANTE_NOMBRE as 'Fabricante',
SUCURSAL_DIRECCION as 'Sucursal'
FROM THE_X_TEAM.Compra_Autoparte comp_auto
INNER JOIN THE_X_TEAM.Autoparte autoparte on autoparte.AUTO_PARTE_CODIGO = comp_auto.AUTO_PARTE_CODIGO
INNER JOIN THE_X_TEAM.Modelo modelo ON autoparte.ID_MODELO = modelo_codigo
INNER JOIN THE_X_TEAM.Fabricante fab on autoparte.ID_FABRICANTE = fab.ID_FABRICANTE
INNER JOIN THE_X_TEAM.Compra compra on comp_auto.COMPRA_NRO = compra.COMPRA_NRO
INNER JOIN THE_X_TEAM.Sucursal suc on suc.ID_SUCURSAL = compra.ID_SUCURSAL
GO


--FACTURACION DE AUTOMOVIL

CREATE VIEW THE_X_TEAM.FacturacionAutomoviles AS
SELECT 
auto_nro_chasis as 'Nro de chasis',
auto_nro_motor as 'Nro de motor',
auto_patente as 'Patente',
CAST(auto_fecha_alta AS DATE) as 'Fecha de Alta', 
auto_cant_kms as 'Cantidad de kilometraje',
modelo_nombre as 'Modelo',
SUCURSAL_DIRECCION as 'Sucursal',
precio_facturado as 'Precio de Venta',
FACTURA_NRO as 'Nro de Factura',
CAST(FACTURA_FECHA as DATE) as 'Fecha de Factura'
FROM THE_X_TEAM.Factura f
INNER JOIN THE_X_TEAM.Auto a ON f.id_auto = a.id_auto
INNER JOIN THE_X_TEAM.Modelo modelo ON a.id_modelo = modelo.modelo_codigo
INNER JOIN THE_X_TEAM.Sucursal sucur ON sucur.ID_SUCURSAL = f.ID_SUCURSAL
GO

-- FACTURACION DE AUTOPARTES
CREATE VIEW THE_X_TEAM.FacturacionAutopartes as
SELECT 
suc.SUCURSAL_CIUDAD as 'Ciudad Origen',
suc.SUCURSAL_DIRECCION as 'Sucursal',
fac_autop.AUTO_PARTE_CODIGO as 'Autoparte Requerida',
CANTIDAD_AUTOPARTE as 'Cantidad Requerida',
autoparte.AUTO_PARTE_DESCRIPCION as 'Rubro',
(autoparte.PRECIO_FACTURADO * CANTIDAD_AUTOPARTE) as 'Precio Total',
ID_FACTURA as 'Nro de Factura',
factura.FACTURA_FECHA as 'Fecha'
FROM THE_X_TEAM.Factura_Autoparte fac_autop
INNER JOIN THE_X_TEAM.Autoparte autoparte on autoparte.AUTO_PARTE_CODIGO = fac_autop.AUTO_PARTE_CODIGO
INNER JOIN THE_X_TEAM.Factura factura on fac_autop.ID_FACTURA = factura.FACTURA_NRO
INNER JOIN THE_X_TEAM.Sucursal suc on factura.ID_SUCURSAL = suc.ID_SUCURSAL
GO

/**********************************************
---------------   INSERTS   -------------------
**********************************************/

-- Insertamos todos los nombres de fabricantes de la tabla maestra, estos luego tendran un ID autogenerado
INSERT INTO THE_X_TEAM.Fabricante
select DISTINCT FABRICANTE_NOMBRE from GD2C2020.gd_esquema.Maestra;
-------------------------------------------------------
-- Insertamos todos los codigos y descripciones de cajas de la tabla maestra
INSERT INTO THE_X_TEAM.Tipo_Caja
select DISTINCT TIPO_CAJA_CODIGO,TIPO_CAJA_DESC from GD2C2020.gd_esquema.Maestra
where TIPO_CAJA_CODIGO is not null;
-------------------------------------------------------
-- Insertamos todos los codigos y descripciones de transmisiones de la tabla maestra
INSERT INTO THE_X_TEAM.Tipo_Transmision
select DISTINCT TIPO_TRANSMISION_CODIGO,TIPO_TRANSMISION_DESC from GD2C2020.gd_esquema.Maestra
where TIPO_TRANSMISION_CODIGO is not null;
-------------------------------------------------------
/*Insertamos todos los codigos de cajas, transmisiones y motores de la tabla maestra, que para algunos autos esta configuracion sera la misma, 
esto nos dará cada config un ID autogenerado que luego usaremos en los Autos*/
insert into THE_X_TEAM.Config_Auto
select DISTINCT TIPO_CAJA_CODIGO, TIPO_TRANSMISION_CODIGO,TIPO_MOTOR_CODIGO from GD2C2020.gd_esquema.Maestra
WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL
and TIPO_MOTOR_CODIGO is not null;
-------------------------------------------------------
--Insertamos todas las direcciones, mail, telefonos y ciudad de cada sucursal de la tabla maestra
insert into THE_X_TEAM.Sucursal
select DISTINCT CONCAT(LEFT(SUCURSAL_DIRECCION,LEN(SUCURSAL_DIRECCION)-4),' ', RIGHT(RTRIM(SUCURSAL_DIRECCION),4)) AS 'SUCURSAL_DIRECCION',
REPLACE(REPLACE(SUCURSAL_MAIL,' ',''),'°','') AS 'SUCURSAL_MAIL',
SUCURSAL_TELEFONO,SUCURSAL_CIUDAD from GD2C2020.gd_esquema.Maestra
WHERE SUCURSAL_DIRECCION IS NOT NULL;
-------------------------------------------------------
--Insertamos los clientes con su DNI, Apellido, nombre, direccion, fecha de nacimiento y mail. Aunque, estos solo seran los clientes que les compramos autos o autopartes
INSERT INTO THE_X_TEAM.Cliente
select distinct CLIENTE_DNI, CLIENTE_APELLIDO, CLIENTE_NOMBRE, CLIENTE_DIRECCION, CLIENTE_FECHA_NAC, 
REPLACE(CLIENTE_MAIL,' ', '')
from GD2C2020.gd_esquema.Maestra
where CLIENTE_DNI IS NOT NULL 
group by CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,CLIENTE_FECHA_NAC,CLIENTE_MAIL

/*Insertamos los clientes a los que les vendimos autos o autopartes con su DNI, Apellido, nombre, direccion, fecha de nacimiento y mail. 
Pero, fijandonos que ya no esten insertados, por si algun cliente nos compro y despues le facturamos*/
INSERT INTO THE_X_TEAM.Cliente
select distinct FAC_CLIENTE_DNI, FAC_CLIENTE_APELLIDO, FAC_CLIENTE_NOMBRE, FAC_CLIENTE_DIRECCION, FAC_CLIENTE_FECHA_NAC, 
REPLACE(FAC_CLIENTE_MAIL,' ', '') AS FAC_CLIENTE_MAIL
from GD2C2020.gd_esquema.Maestra
where FAC_CLIENTE_DNI IS NOT NULL 
AND NOT EXISTS (
	SELECT * FROM THE_X_TEAM.CLIENTE
	where CLIENTE_DNI = FAC_CLIENTE_DNI AND
	CLIENTE_APELLIDO = FAC_CLIENTE_APELLIDO AND
	CLIENTE_NOMBRE = FAC_CLIENTE_NOMBRE AND
	CLIENTE_DIRECCION = FAC_CLIENTE_DIRECCION AND
	CLIENTE_FECHA_NAC = FAC_CLIENTE_FECHA_NAC AND
	CLIENTE_MAIL = FAC_CLIENTE_MAIL
)
group by FAC_CLIENTE_DNI,FAC_CLIENTE_APELLIDO,FAC_CLIENTE_NOMBRE,FAC_CLIENTE_DIRECCION,FAC_CLIENTE_FECHA_NAC,FAC_CLIENTE_MAIL
-------------------------------------------------------
--Insertamos todos los codigos, nombre y potencia de cada modelo de la tabla maestra
insert into THE_X_TEAM.Modelo
select modelo_codigo, modelo_nombre, modelo_potencia from GD2C2020.gd_esquema.Maestra
group by modelo_codigo, modelo_nombre, modelo_potencia;
-------------------------------------------------------
/*Insertamos todos los codigos, descripciones, precio de compra y venta de cada Autoparte de la tabla maestra.
Ademas, llenamos su codigo de modelo y fabricante, comprarando sus nombres con las tablas creadas anteriormente para darnos este codigo.
*/
insert into THE_X_TEAM.Autoparte
select DISTINCT maestra.AUTO_PARTE_CODIGO, AUTO_PARTE_DESCRIPCION, fab.id_fabricante, MODELO_CODIGO, t.COMPRA_PRECIO, PRECIO_FACTURADO 
from GD2C2020.gd_esquema.Maestra maestra
inner join THE_X_TEAM.Fabricante fab
on fab.fabricante_nombre = maestra.fabricante_nombre
inner join (
	select DISTINCT AUTO_PARTE_CODIGO, COMPRA_PRECIO from GD2C2020.gd_esquema.Maestra maestra
	inner join THE_X_TEAM.Fabricante fab on fab.fabricante_nombre = maestra.fabricante_nombre
	WHERE AUTO_PARTE_CODIGO IS NOT NULL 
	AND PRECIO_FACTURADO IS NULL
	) T
on t.AUTO_PARTE_CODIGO = maestra.AUTO_PARTE_CODIGO
WHERE maestra.AUTO_PARTE_CODIGO IS NOT NULL
AND maestra.COMPRA_PRECIO IS NULL
-------------------------------------------------------
--Insertamos todos los codigos y descripcion de cada tipo de auto de la tabla maestra
INSERT INTO THE_X_TEAM.Tipo_Auto
select tipo_auto_codigo, tipo_auto_desc from GD2C2020.gd_esquema.Maestra
where TIPO_AUTO_CODIGO is not null
group by tipo_auto_codigo,tipo_auto_desc;
-------------------------------------------------------
/*Insertamos todos los chasis, nro de motor, precio de compra y venta de cada Auto de la tabla maestra.
Ademas, llenamos su codigo de modelo, fabricante y tipo de auto, comprarando sus nombres con las tablas creadas anteriormente para darnos este codigo.
*/
insert into THE_X_TEAM.Auto
select auto_patente,
auto_nro_chasis,
auto_nro_motor,
auto_fecha_alta,
auto_cant_kms,
(select id_fabricante from THE_X_TEAM.Fabricante where maestra.FABRICANTE_NOMBRE = Fabricante.FABRICANTE_NOMBRE) as idFab,
(select MODELO_CODIGO from THE_X_TEAM.Modelo where maestra.MODELO_CODIGO = Modelo.MODELO_CODIGO) as idModelo,
(select TIPO_AUTO_CODIGO from THE_X_TEAM.tipo_auto where maestra.TIPO_AUTO_CODIGO = tipo_auto.tipo_auto_codigo) as tipoAuto,
sum(precio_facturado) as PRECIO_FACTURADO,
compra_precio,
ca.id_config from GD2C2020.gd_esquema.Maestra maestra
inner join THE_X_TEAM.config_auto ca
on ca.ID_CAJA = maestra.TIPO_CAJA_CODIGO
and ca.id_transmision = maestra.TIPO_TRANSMISION_CODIGO
and ca.tipo_motor_codigo = maestra.TIPO_MOTOR_CODIGO
group by AUTO_PATENTE,AUTO_NRO_CHASIS,AUTO_NRO_motor,AUTO_FECHA_ALTA,AUTO_CANT_KMS,FABRICANTE_NOMBRE,MODELO_CODIGO,TIPO_AUTO_CODIGO,compra_precio,ca.id_config
-------------------------------------------------------
--Insertamos todos los codigos, fecha, sucursal, cliente y auto de cada compra de la tabla maestra.
--El dato id_auto puede ser null ya que esto significa que la compra fue de una autoparte.
--no necesitamos el id de autoparte, ya que lo tendremos en otra tabla que tendra las distintas autopartes que se hicieron en esa compra
insert into THE_X_TEAM.Compra
select DISTINCT COMPRA_NRO, COMPRA_FECHA, 
(Select ID_CLIENTE FROM THE_X_TEAM.Cliente WHERE (CLIENTE_DNI= maestra.CLIENTE_DNI and CLIENTE_NOMBRE = maestra.CLIENTE_NOMBRE)), 
(Select ID_SUCURSAL FROM THE_X_TEAM.Sucursal WHERE SUCURSAL_DIRECCION=maestra.SUCURSAL_DIRECCION),
(Select distinct id_auto FROM THE_X_TEAM.Auto where AUTO_PATENTE = maestra.AUTO_PATENTE)
from GD2C2020.gd_esquema.Maestra maestra
WHERE COMPRA_NRO IS NOT NULL;
-------------------------------------------------------
--Insertamos todos los codigos, fecha, sucursal, cliente y auto de cada venta de la tabla maestra.
--El dato id_auto puede ser null ya que esto significa que la venta fue de una autoparte.
--no necesitamos el id de autoparte, ya que lo tendremos en otra tabla que tendra las distintas autopartes que se hicieron en esa venta
insert into THE_X_TEAM.Factura (FACTURA_NRO,FACTURA_FECHA,ID_CLIENTE,ID_SUCURSAL,ID_AUTO)
select DISTINCT FACTURA_NRO, FACTURA_FECHA, 
(Select ID_CLIENTE FROM THE_X_TEAM.Cliente WHERE (CLIENTE_DNI= maestra.FAC_CLIENTE_DNI and CLIENTE_NOMBRE = maestra.FAC_CLIENTE_NOMBRE)), 
(Select ID_SUCURSAL FROM THE_X_TEAM.Sucursal 
WHERE SUCURSAL_DIRECCION=CONCAT(LEFT(maestra.FAC_SUCURSAL_DIRECCION,LEN(maestra.FAC_SUCURSAL_DIRECCION)-4),' ', RIGHT(RTRIM(maestra.FAC_SUCURSAL_DIRECCION),4))),
(Select distinct id_auto FROM THE_X_TEAM.Auto where AUTO_PATENTE = maestra.AUTO_PATENTE)
from GD2C2020.gd_esquema.Maestra maestra
WHERE FACTURA_NRO IS NOT NULL;

-------------------------------------------------------
--Esta tabla tendra todas las autopartes que se hicieron en cada compra, ademas de la cantidad de autopartes que se compraron.
INSERT INTO THE_X_TEAM.Compra_Autoparte
SELECT AUTO_PARTE_CODIGO, COMPRA_NRO,SUM(COMPRA_CANT) as CantidadItems
FROM GD2C2020.gd_esquema.Maestra 
WHERE (AUTO_PARTE_CODIGO IS NOT NULL AND COMPRA_NRO IS NOT NULL)
GROUP BY AUTO_PARTE_CODIGO, COMPRA_NRO
-------------------------------------------------------
--Esta tabla tendra todas las autopartes que se hicieron en cada venta, ademas de la cantidad de autopartes que se venta.
INSERT INTO THE_X_TEAM.Factura_Autoparte
SELECT AUTO_PARTE_CODIGO, FACTURA_NRO,SUM(cant_facturada) as CantidadItems
FROM GD2C2020.gd_esquema.Maestra 
WHERE (AUTO_PARTE_CODIGO IS NOT NULL AND FACTURA_NRO IS NOT NULL)
GROUP BY AUTO_PARTE_CODIGO, FACTURA_NRO
GO
