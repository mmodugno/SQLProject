use GD2C2020
go
--drop schema THE_X_TEAM

IF EXISTS (
	SELECT * 
	FROM sys.tables 
	WHERE object_name(object_id) = 'BI_CLIENTE'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_CLIENTE

IF EXISTS (
	SELECT * 
	FROM sys.tables 
	WHERE object_name(object_id) = 'BI_SUCURSAL'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_SUCURSAL

IF EXISTS (
	SELECT * 
	FROM sys.tables 
	WHERE object_name(object_id) = 'BI_MODELO'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_MODELO

IF EXISTS (
	SELECT * 
	FROM sys.tables 
	WHERE object_name(object_id) = 'BI_TIEMPO'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_TIEMPO

IF EXISTS (
	SELECT * 
	FROM sys.tables 
	WHERE object_name(object_id) = 'BI_AUTOPARTE'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_AUTOPARTE

IF EXISTS (
	SELECT * 
	FROM sys.tables 
	WHERE object_name(object_id) = 'BI_Factura_Auto'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_Factura_Auto

IF EXISTS (
	SELECT * 
	FROM sys.tables 
	WHERE object_name(object_id) = 'BI_Factura_Autoparte'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_Factura_Autoparte
	
IF EXISTS (
	SELECT * 
	FROM sys.tables 
	WHERE object_name(object_id) = 'BI_Compra_Autoparte'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_Compra_Autoparte
	
IF EXISTS (
	SELECT * 
	FROM sys.tables 
	WHERE object_name(object_id) = 'BI_Compra_Auto'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_Compra_Auto


-----------------/////// FACTURACION de AUTO /////////-----------------

/* BI_CLIENTE */
CREATE TABLE THE_X_TEAM.BI_CLIENTE(
"ID_CLIENTE" int PRIMARY KEY,
"CLIENTE_FECHA_NAC" DATETIME2(3),
"CLIENTE_SEXO" char(1)
);

/* BI_SUCURSAL */
CREATE TABLE THE_X_TEAM.BI_SUCURSAL(
"ID_SUCURSAL" int PRIMARY KEY,
"SUCURSAL_DIRECCION" NVARCHAR(255)
);

/* BI_AUTO */
CREATE TABLE THE_X_TEAM.BI_AUTO(
"ID_AUTO" int PRIMARY KEY,
"AUTO_NRO_MOTOR" NVARCHAR(50),
"ID_MODELO" decimal(18,0),
"TIPO_AUTO" decimal(18,0),
"PRECIO_FACTURADO" decimal(18,2),
"TIPO_CAJA_CODIGO" decimal(18,0),
"TIPO_TRANSMISION" decimal(18,0),
"FABRICANTE_NOMBRE" NVARCHAR(255)
);

/* BI_MODELO */
CREATE TABLE THE_X_TEAM.BI_MODELO(
"MODELO_CODIGO" decimal(18,0) PRIMARY KEY,
"MODELO_NOMBRE" NVARCHAR(255),
"MODELO_POTENCIA" decimal(18,0)
);

/* BI_TIEMPO */
CREATE TABLE THE_X_TEAM.BI_TIEMPO(
"CODIGO_ANIO" decimal(4,0) PRIMARY KEY,
"CODIGO_MES" decimal(2,0)
);

/* BI_Factura_Auto */
CREATE TABLE THE_X_TEAM.BI_Factura_Auto(
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_CLIENTE,
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_SUCURSAL,
"ID_AUTO" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_AUTO,
"FACTURA_FECHA" DATETIME2(3)
);

-----------------/////// FACTURACION de AUTOPARTES /////////-----------------

CREATE TABLE THE_X_TEAM.BI_AUTOPARTE(
"ID_AUTOPARTE" int PRIMARY KEY,
"FABRICANTE_NOMBRE" NVARCHAR(255),
"RUBRO_AUTOPARTE" NVARCHAR(255),
"PRECIO_FACTURADO" decimal(18,2),
"ID_MODELO" decimal(18,0)
--,"CANTIDAD_STOCK" int
);

/* BI_Factura_Autoparte */
CREATE TABLE THE_X_TEAM.BI_Factura_Autoparte(
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_CLIENTE,
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_SUCURSAL,
"ID_AUTO_PARTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_AUTOPARTE,
"FACTURA_FECHA" DATETIME2(3)
);

-----------------/////// COMPRA de AUTO /////////-----------------
/* BI_Compra_Auto */
CREATE TABLE THE_X_TEAM.BI_Compra_Auto(
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_CLIENTE,
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_SUCURSAL,
"ID_AUTO" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_AUTO,
"COMPRA_FECHA" DATETIME2(3)
);

-----------------/////// COMPRA de AUTOPARTES /////////-----------------
/* BI_Compra_Auto */
CREATE TABLE THE_X_TEAM.BI_Compra_Autoparte(
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_CLIENTE,
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_SUCURSAL,
"ID_AUTO_PARTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_AUTOPARTE,
"COMPRA_FECHA" DATETIME2(3)
);
