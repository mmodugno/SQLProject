use GD2C2020
go
--drop schema THE_X_TEAM

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
	WHERE object_name(object_id) = 'BI_AUTO'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop table THE_X_TEAM.BI_AUTO

IF EXISTS (
	SELECT * 
	FROM sys.objects 
	WHERE object_name(object_id) = 'stockTotalAutoParte'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop function THE_X_TEAM.stockTotalAutoParte


-----------------/////// FACTURACION de AUTO /////////-----------------

/* BI_CLIENTE */
CREATE TABLE THE_X_TEAM.BI_CLIENTE(
"ID_CLIENTE" int PRIMARY KEY,
"CLIENTE_FECHA_NAC" DATE,
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
"TIPO_CAJA" NVARCHAR(255),
"TIPO_TRANSMISION" NVARCHAR(255),
"FABRICANTE_NOMBRE" NVARCHAR(255),
"DIAS_STOCK" decimal(18,0)
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

CREATE TABLE THE_X_TEAM.BI_AUTOPARTE(
"ID_AUTOPARTE" int PRIMARY KEY,
"FABRICANTE_NOMBRE" NVARCHAR(255),
"RUBRO_AUTOPARTE" NVARCHAR(255),
"PRECIO_FACTURADO" decimal(18,2),
"ID_MODELO" decimal(18,0),
"CANTIDAD_STOCK" int
);

-----------------/////// FACTURACION de AUTOPARTES /////////-----------------

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
"COMPRA_FECHA" DATE
CONSTRAINT COMPRA_AUTO_PK PRIMARY KEY (ID_CLIENTE, ID_SUCURSAL, ID_AUTO)
);

-----------------/////// COMPRA de AUTOPARTES /////////-----------------
/* BI_Compra_AutoPARTE */
CREATE TABLE THE_X_TEAM.BI_Compra_Autoparte(
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_CLIENTE,
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_SUCURSAL,
"ID_AUTO_PARTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_AUTOPARTE,
"COMPRA_FECHA" DATETIME2(3)
);
GO

/**********************************************************************
***************************** FUNCTIONS *******************************
***********************************************************************/

CREATE FUNCTION THE_X_TEAM.stockTotalAutoParte (@codigoAutoparte decimal(18,0))
returns int
AS
	BEGIN 
	DECLARE @CantidadVendidos int
	DECLARE @CantidadComprados int

	SET @CantidadComprados = (SELECT SUM(CANTIDAD_AUTOPARTE) from THE_X_TEAM.COMPRA_AUTOPARTE AP
								WHERE AP.AUTO_PARTE_CODIGO = @codigoAutoparte
								GROUP BY AUTO_PARTE_CODIGO)
	

	SET @CantidadVendidos = (SELECT SUM(CANTIDAD_AUTOPARTE) from THE_X_TEAM.Factura_Autoparte AP
								WHERE AP.AUTO_PARTE_CODIGO = @codigoAutoparte
								GROUP BY AUTO_PARTE_CODIGO)
	
	RETURN (@CantidadComprados - @CantidadVendidos)
	END 
GO

/**********************************************************************
****************************** INSERTS ********************************
***********************************************************************/

--Cliente--
INSERT INTO THE_X_TEAM.BI_CLIENTE 
	SELECT CLI.ID_CLIENTE, CAST(CLI.CLIENTE_FECHA_NAC AS DATE), NULL
	FROM THE_X_TEAM.Cliente CLI
GO

--Sucursal--
INSERT INTO THE_X_TEAM.BI_SUCURSAL 
	SELECT SUC.ID_SUCURSAL, SUC.SUCURSAL_DIRECCION
	FROM THE_X_TEAM.Sucursal SUC
GO

--Modelo--
INSERT INTO THE_X_TEAM.BI_MODELO 
	SELECT M.MODELO_CODIGO, M.MODELO_NOMBRE, M.MODELO_POTENCIA
	FROM THE_X_TEAM.Modelo M
GO

--Auto--
INSERT INTO THE_X_TEAM.BI_AUTO 
	SELECT A.ID_AUTO, A.AUTO_NRO_MOTOR, A.ID_MODELO, A.TIPO_AUTO, A.PRECIO_FACTURADO, TC.TIPO_CAJA_DESC, TT.TIPO_TRANSMISION_DESC, FAB.FABRICANTE_NOMBRE, 
	CASE
		WHEN F.FACTURA_FECHA is not null then ABS(DATEDIFF(DAY,F.FACTURA_FECHA,com.COMPRA_FECHA))
		ELSE ABS(DATEDIFF(DAY,GETDATE(),com.COMPRA_FECHA))
	END AS DIAS
	FROM THE_X_TEAM.Auto A
		LEFT OUTER JOIN THE_X_TEAM.Factura F
			on A.id_auto = F.ID_AUTO
		INNER JOIN THE_X_TEAM.Config_Auto CA
			on CA.ID_CONFIG = A.ID_CONFIG
		INNER JOIN THE_X_TEAM.Tipo_Caja TC
			on TC.TIPO_CAJA_CODIGO = CA.ID_CAJA
		INNER JOIN THE_X_TEAM.Tipo_Transmision TT
			on TT.TIPO_TRANSMISION_CODIGO = CA.ID_TRANSMISION
		INNER JOIN THE_X_TEAM.Fabricante FAB
			on FAB.ID_FABRICANTE = A.ID_FABRICANTE
		INNER JOIN THE_X_TEAM.Compra com
			on com.id_auto= A.id_auto
GO

--Compra Auto--
INSERT INTO THE_X_TEAM.BI_COMPRA_AUTO 
	SELECT ID_CLIENTE, ID_SUCURSAL, C.ID_AUTO, CAST(COMPRA_FECHA AS DATE)
	FROM THE_X_TEAM.COMPRA C
		INNER JOIN THE_X_TEAM.AUTO A	
			on A.ID_AUTO = C.ID_AUTO
GO

--Autoparte--
INSERT INTO THE_X_TEAM.BI_AUTOPARTE
	SELECT AP.AUTO_PARTE_CODIGO, FAB.FABRICANTE_NOMBRE, AP.AUTO_PARTE_DESCRIPCION, AP.PRECIO_FACTURADO, AP.ID_MODELO, THE_X_TEAM.stockTotalAutoParte(AP.AUTO_PARTE_CODIGO) 
	FROM THE_X_TEAM.AUTOPARTE AP
	INNER JOIN THE_X_TEAM.Fabricante FAB
			on FAB.ID_FABRICANTE = AP.ID_FABRICANTE
GO

--Compra Autoparte--
INSERT INTO THE_X_TEAM.BI_Compra_Autoparte
	SELECT ID_CLIENTE, ID_SUCURSAL, A.AUTO_PARTE_CODIGO, CAST(COMPRA_FECHA AS DATE)
	FROM THE_X_TEAM.COMPRA C
		INNER JOIN THE_X_TEAM.Compra_Autoparte A	
			on A.COMPRA_NRO = C.COMPRA_NRO
GO

--Facturacion Auto--
INSERT INTO THE_X_TEAM.BI_Factura_Auto
	SELECT ID_CLIENTE, ID_SUCURSAL, F.ID_AUTO, CAST(FACTURA_FECHA AS DATE)
	FROM THE_X_TEAM.Factura F
		INNER JOIN THE_X_TEAM.AUTO A	
			on A.ID_AUTO = F.ID_AUTO
	order by ID_CLIENTE
GO

--Facturacion Autoparte--
INSERT INTO THE_X_TEAM.BI_Factura_Autoparte
	SELECT ID_CLIENTE, ID_SUCURSAL, A.AUTO_PARTE_CODIGO, CAST(FACTURA_FECHA AS DATE)
	FROM THE_X_TEAM.Factura F
		INNER JOIN THE_X_TEAM.Factura_Autoparte A	
			on A.ID_FACTURA = F.FACTURA_NRO
GO
