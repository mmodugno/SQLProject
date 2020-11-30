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

IF EXISTS (
	SELECT * 
	FROM sys.objects 
	WHERE object_name(object_id) = 'stockTotalAutoParteANUAL'
	AND schema_name(schema_id) = 'THE_X_TEAM'
)
	drop function THE_X_TEAM.stockTotalAutoParteANUAL


-----------------/////// FACTURACION de AUTO /////////-----------------

/* BI_CLIENTE */
CREATE TABLE THE_X_TEAM.BI_CLIENTE(
"ID_CLIENTE" int PRIMARY KEY,
"CLIENTE_FECHA_NAC" DATE,
"EDAD" NVARCHAR(50),
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
"TIPO_CAJA" NVARCHAR(255),
"TIPO_TRANSMISION" NVARCHAR(255),
"FABRICANTE_NOMBRE" NVARCHAR(255),
"DIAS_STOCK" decimal(18,0)
);

/* BI_MODELO */
CREATE TABLE THE_X_TEAM.BI_MODELO(
"MODELO_CODIGO" decimal(18,0) PRIMARY KEY,
"MODELO_NOMBRE" NVARCHAR(255),
"MODELO_POTENCIA" NVARCHAR(50)
);

/* BI_TIEMPO */
CREATE TABLE THE_X_TEAM.BI_TIEMPO(
"CODIGO_TIEMPO" INT IDENTITY(1,1) PRIMARY KEY,
"CODIGO_ANIO" decimal(4,0),
"CODIGO_MES" decimal(2,0)
);

CREATE TABLE THE_X_TEAM.BI_AUTOPARTE(
"ID_AUTOPARTE" int PRIMARY KEY,
"FABRICANTE_NOMBRE" NVARCHAR(255),
"RUBRO_AUTOPARTE" NVARCHAR(255),
"ID_MODELO" decimal(18,0),
"CANTIDAD_STOCK" int
);

-----------------/////// FACTURACION /////////-----------------

/* BI_Factura_Autoparte */
CREATE TABLE THE_X_TEAM.BI_Factura_Autoparte(
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_CLIENTE,
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_SUCURSAL,
"ID_AUTO_PARTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_AUTOPARTE,
"ID_TIEMPO" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_TIEMPO,
"PRECIO_FACTURADO" decimal(18,2)
CONSTRAINT FACTURA_AUTOPARTE_PK PRIMARY KEY (ID_CLIENTE, ID_SUCURSAL, ID_AUTO_PARTE, ID_TIEMPO)
);
/* BI_Factura_Auto */
CREATE TABLE THE_X_TEAM.BI_Factura_Auto(
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_CLIENTE,
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_SUCURSAL,
"ID_AUTO" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_AUTO,
"ID_TIEMPO" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_TIEMPO,
"PRECIO_FACTURADO" decimal(18,2)
CONSTRAINT FACTURA_AUTO_PK PRIMARY KEY (ID_CLIENTE, ID_SUCURSAL, ID_AUTO, ID_TIEMPO)
);
-----------------/////// COMPRA de AUTO /////////-----------------
/* BI_Compra_Auto */
CREATE TABLE THE_X_TEAM.BI_Compra_Auto(
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_CLIENTE,
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_SUCURSAL,
"ID_AUTO" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_AUTO,
"ID_TIEMPO" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_TIEMPO,
"PRECIO_COMPRA" decimal(18,2)
CONSTRAINT COMPRA_AUTO_PK PRIMARY KEY (ID_CLIENTE, ID_SUCURSAL, ID_AUTO, ID_TIEMPO)
);
-----------------/////// COMPRA de AUTOPARTES /////////-----------------
/* BI_Compra_AutoPARTE */
CREATE TABLE THE_X_TEAM.BI_Compra_Autoparte(
"ID_CLIENTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_CLIENTE,
"ID_SUCURSAL" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_SUCURSAL,
"ID_AUTO_PARTE" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_AUTOPARTE,
"ID_TIEMPO" int FOREIGN KEY REFERENCES THE_X_TEAM.BI_TIEMPO,
"PRECIO_COMPRA" decimal(18,2)
CONSTRAINT COMPRA_AUTOPARTE_PK PRIMARY KEY (ID_CLIENTE, ID_SUCURSAL, ID_AUTO_PARTE, ID_TIEMPO)
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
/*
CREATE FUNCTION THE_X_TEAM.stockTotalAutoParteANUAL (@codigoAutoparte decimal(18,0),@anio int,@sucursal int)
returns int
AS
	BEGIN 
	DECLARE @CantidadVendidos int
	DECLARE @CantidadComprados int

	SET @CantidadComprados = ISNULL((SELECT SUM(CANTIDAD_AUTOPARTE) from THE_X_TEAM.COMPRA_AUTOPARTE AP 
									INNER JOIN THE_X_TEAM.Compra c
								on c.COMPRA_NRO= ap.COMPRA_NRO
								WHERE AP.AUTO_PARTE_CODIGO = @codigoAutoparte 
								AND YEAR(c.COMPRA_FECHA) = @anio
								AND @sucursal = c.ID_SUCURSAL
								GROUP BY AUTO_PARTE_CODIGO),0)
	

	SET @CantidadVendidos = isNULL((SELECT SUM(CANTIDAD_AUTOPARTE) from THE_X_TEAM.Factura_Autoparte AP
									INNER JOIN THE_X_TEAM.Factura f
								on f.FACTURA_NRO= ap.ID_FACTURA
								WHERE AP.AUTO_PARTE_CODIGO = @codigoAutoparte 
								AND YEAR(f.FACTURA_FECHA) = @anio
								AND @sucursal = f.ID_SUCURSAL
								GROUP BY AUTO_PARTE_CODIGO),0)
	
	RETURN (@CantidadComprados - @CantidadVendidos)
	END 
GO*/


/**********************************************************************
****************************** INSERTS ********************************
***********************************************************************/

--Tiempo
INSERT INTO THE_X_TEAM.BI_TIEMPO
	SELECT YEAR(COMPRA_FECHA) AS Anio, MONTH(COMPRA_FECHA) AS Mes FROM THE_X_TEAM.COMPRA
	GROUP BY YEAR(COMPRA_FECHA), MONTH(COMPRA_FECHA)
		UNION 
	SELECT YEAR(FACTURA_FECHA) AS Anio, MONTH(FACTURA_FECHA) AS Mes FROM THE_X_TEAM.FACTURA
	GROUP BY YEAR(FACTURA_FECHA), MONTH(FACTURA_FECHA)
GO

--Cliente--
INSERT INTO THE_X_TEAM.BI_CLIENTE 
	SELECT CLI.ID_CLIENTE, CAST(CLI.CLIENTE_FECHA_NAC AS DATE),
	CASE 
		WHEN DATEDIFF(YEAR,CLI.CLIENTE_FECHA_NAC,GETDATE()) BETWEEN 18 and 30 THEN '18 - 30 Anios'
		WHEN DATEDIFF(YEAR,CLI.CLIENTE_FECHA_NAC,GETDATE()) BETWEEN 31 and 50 THEN '31 - 50 Anios'
		ELSE '> 50 anios'
	END
	, NULL
	FROM THE_X_TEAM.Cliente CLI
GO

--Sucursal--
INSERT INTO THE_X_TEAM.BI_SUCURSAL 
	SELECT SUC.ID_SUCURSAL, SUC.SUCURSAL_DIRECCION
	FROM THE_X_TEAM.Sucursal SUC
GO

--Modelo--
INSERT INTO THE_X_TEAM.BI_MODELO 
	SELECT M.MODELO_CODIGO, M.MODELO_NOMBRE,CASE 
		WHEN M.modelo_potencia BETWEEN 50 and 150 THEN '50 - 150cv'
		WHEN M.modelo_potencia BETWEEN 151 and 300 THEN '151 - 300cv'
		ELSE '> 300cv'
	END
	FROM THE_X_TEAM.Modelo M
GO

--Auto--
INSERT INTO THE_X_TEAM.BI_AUTO 
	SELECT A.ID_AUTO, A.AUTO_NRO_MOTOR, A.ID_MODELO, A.TIPO_AUTO, TC.TIPO_CAJA_DESC, TT.TIPO_TRANSMISION_DESC, FAB.FABRICANTE_NOMBRE, 
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
	SELECT  ID_CLIENTE, ID_SUCURSAL, C.ID_AUTO, 
			(SELECT T.CODIGO_TIEMPO FROM THE_X_TEAM.BI_TIEMPO T
				WHERE YEAR(C.COMPRA_FECHA)=T.CODIGO_ANIO 
					AND MONTH(C.COMPRA_FECHA)=T.CODIGO_MES) as ID_TIEMPO,
			A.COMPRA_PRECIO
	FROM THE_X_TEAM.COMPRA C
		INNER JOIN THE_X_TEAM.AUTO A	
			on A.ID_AUTO = C.ID_AUTO
			--ORDER
GO

--Autoparte--
INSERT INTO THE_X_TEAM.BI_AUTOPARTE
	SELECT AP.AUTO_PARTE_CODIGO, FAB.FABRICANTE_NOMBRE, AP.AUTO_PARTE_DESCRIPCION, AP.ID_MODELO, THE_X_TEAM.stockTotalAutoParte(AP.AUTO_PARTE_CODIGO) 
	FROM THE_X_TEAM.AUTOPARTE AP
	INNER JOIN THE_X_TEAM.Fabricante FAB
			on FAB.ID_FABRICANTE = AP.ID_FABRICANTE
GO

--SELECT * FROM THE_X_TEAM.BI_AUTOPARTE


--Compra Autoparte--
INSERT INTO THE_X_TEAM.BI_Compra_Autoparte
	SELECT  ID_CLIENTE, ID_SUCURSAL, AP.AUTO_PARTE_CODIGO, 
			(SELECT T.CODIGO_TIEMPO FROM THE_X_TEAM.BI_TIEMPO T
				WHERE YEAR(C.COMPRA_FECHA)=T.CODIGO_ANIO 
					AND MONTH(C.COMPRA_FECHA)=T.CODIGO_MES) as ID_TIEMPO,
			AP.COMPRA_PRECIO
	FROM THE_X_TEAM.COMPRA C
		INNER JOIN THE_X_TEAM.Compra_Autoparte CA	
			on C.COMPRA_NRO = CA.COMPRA_NRO
		INNER JOIN THE_X_TEAM.AUTOPARTE AP
			on AP.AUTO_PARTE_CODIGO = CA.AUTO_PARTE_CODIGO
GO

--Facturacion Auto--
INSERT INTO THE_X_TEAM.BI_Factura_Auto
	SELECT  ID_CLIENTE, ID_SUCURSAL, F.ID_AUTO,
			(SELECT T.CODIGO_TIEMPO FROM THE_X_TEAM.BI_TIEMPO T
				WHERE YEAR(F.FACTURA_FECHA)=T.CODIGO_ANIO 
					AND MONTH(F.FACTURA_FECHA)=T.CODIGO_MES) as ID_TIEMPO, 
			A.PRECIO_FACTURADO
	FROM THE_X_TEAM.Factura F
		INNER JOIN THE_X_TEAM.AUTO A	
			on A.ID_AUTO = F.ID_AUTO
	order by ID_CLIENTE
GO

--Facturacion Autoparte--
INSERT INTO THE_X_TEAM.BI_Factura_Autoparte
	SELECT ID_CLIENTE, ID_SUCURSAL, AP.AUTO_PARTE_CODIGO,
		   (SELECT T.CODIGO_TIEMPO FROM THE_X_TEAM.BI_TIEMPO T
				WHERE YEAR(F.FACTURA_FECHA)=T.CODIGO_ANIO 
					AND MONTH(F.FACTURA_FECHA)=T.CODIGO_MES) as ID_TIEMPO, 
		   AP.PRECIO_FACTURADO
	FROM THE_X_TEAM.Factura F
		INNER JOIN THE_X_TEAM.Factura_Autoparte A	
			on A.ID_FACTURA = F.FACTURA_NRO
		INNER JOIN THE_X_TEAM.AUTOPARTE AP
			on AP.AUTO_PARTE_CODIGO = A.AUTO_PARTE_CODIGO
GO

/* Automóviles:
o ----Cantidad de automóviles, vendidos y comprados x sucursal y mes
o ----Precio promedio de automóviles, vendidos y comprados.
o ----Ganancias (precio de venta – precio de compra) x Sucursal x mes
o ----Promedio de tiempo en stock de cada modelo de automóvil.
o
 Autopartes
o ----Precio promedio de cada autoparte, vendida y comprada.
o ----Ganancias (precio de venta – precio de compra) x Sucursal x mes
o ----Promedio de tiempo en stock de cada autoparte.
o Máxima cantidad de stock por cada sucursal (anual)  */

IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'Precio_Promedio'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.Precio_Promedio
GO
IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'Promedio_Tiempo_stock_Modelos'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.Promedio_Tiempo_stock_Modelos
GO
IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'CANT_AUTO_TRANSACCION'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.CANT_AUTO_TRANSACCION
GO
IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'GANANCIAS_AUTO'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.GANANCIAS_AUTO
GO

IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'Precio_Promedio_Autopartes'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.Precio_Promedio_Autopartes
GO

IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'GANANCIAS_AUTOPARTE'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.GANANCIAS_AUTOPARTE
GO

IF EXISTS (
		SELECT *
		FROM sys.VIEWS
		WHERE object_name(object_id) = 'MAXIMO_STOCK_ANUAL'
			AND schema_name(schema_id) = 'THE_X_TEAM'
		)
	DROP VIEW THE_X_TEAM.MAXIMO_STOCK_ANUAL
GO

CREATE VIEW THE_X_TEAM.Precio_Promedio 
	AS
	SELECT 'Compra' as Operacion, AVG(CA.PRECIO_COMPRA) as Promedio FROM THE_X_TEAM.BI_Compra_Auto CA
			UNION
	SELECT 'Venta' , AVG(FA.PRECIO_FACTURADO) FROM THE_X_TEAM.BI_Factura_Auto FA
GO

CREATE VIEW THE_X_TEAM.Promedio_Tiempo_stock_Modelos 
	AS
	SELECT  M.MODELO_NOMBRE as 'Nombre de Modelo',
			AVG(A.DIAS_STOCK) as 'Promedio en Stock en Dias'
	FROM THE_X_TEAM.BI_MODELO M
		INNER JOIN THE_X_TEAM.BI_AUTO A
			on M.MODELO_CODIGO = A.ID_MODELO
	GROUP BY MODELO_NOMBRE
GO

--Cantidad de automóviles, vendidos y comprados x sucursal y mes
CREATE VIEW THE_X_TEAM.CANT_AUTO_TRANSACCION
	AS
		SELECT  COUNT(*) as 'Cantidad de Autos',
				CA.ID_SUCURSAL as 'Sucursal',
				(SELECT CODIGO_ANIO FROM THE_X_TEAM.BI_TIEMPO
					WHERE CODIGO_TIEMPO = CA.ID_TIEMPO) as 'Anio' ,
				(SELECT DATENAME(MONTH, DATEADD(month,CODIGO_MES , 0 ) - 1 ) FROM THE_X_TEAM.BI_TIEMPO
					WHERE CODIGO_TIEMPO = CA.ID_TIEMPO) as 'Mes' ,
					'Compra' as 'Operación'
			FROM THE_X_TEAM.BI_Compra_Auto CA
		group by CA.ID_SUCURSAL, CA.ID_TIEMPO
			UNION
		SELECT  COUNT(*) as 'Cantidad de Autos',
				FA.ID_SUCURSAL as 'Sucursal',
				(SELECT CODIGO_ANIO FROM THE_X_TEAM.BI_TIEMPO
					WHERE CODIGO_TIEMPO = FA.ID_TIEMPO) as 'Anio' ,
				(SELECT DATENAME(MONTH, DATEADD(month,CODIGO_MES , 0 ) - 1 ) FROM THE_X_TEAM.BI_TIEMPO
					WHERE CODIGO_TIEMPO = FA.ID_TIEMPO) as 'Mes', 
					'Venta' as 'Operación'
			FROM THE_X_TEAM.BI_Factura_Auto FA
		group by FA.ID_SUCURSAL, FA.ID_TIEMPO
		--ORDER BY 2,3
go

--Ganancias (precio de venta – precio de compra) x Sucursal x mes
CREATE VIEW THE_X_TEAM.GANANCIAS_AUTO
	AS
		SELECT DATENAME(MONTH, DATEADD(month,T.CODIGO_MES , 0 ) - 1 ) as 'Mes',
			T.CODIGO_ANIO as 'Anio',
			SUM(FA.PRECIO_FACTURADO - CA.PRECIO_COMPRA) as 'Ganancia'
		FROM THE_X_TEAM.BI_TIEMPO T
			INNER JOIN THE_X_TEAM.BI_Compra_Auto CA 
		on t.CODIGO_TIEMPO = ca.ID_TIEMPO
			INNER JOIN THE_X_TEAM.BI_Factura_Auto FA
		on CA.ID_AUTO = FA.ID_AUTO
		group by T.CODIGO_MES,CODIGO_ANIO
go

CREATE VIEW THE_X_TEAM.Precio_Promedio_Autopartes
	AS
	SELECT 'Compra' as Operacion, AVG(CA.PRECIO_COMPRA) as Promedio , AP.ID_AUTOPARTE as 'ID de Autoparte'
	FROM THE_X_TEAM.BI_Compra_Autoparte CA 
		INNER JOIN THE_X_TEAM.BI_AUTOPARTE AP 
	on CA.ID_AUTO_PARTE = AP.ID_AUTOPARTE
	GROUP BY AP.ID_AUTOPARTE
	
			UNION
	SELECT 'Venta' , AVG(FA.PRECIO_FACTURADO) as Promedio , AP.ID_AUTOPARTE as 'ID de Autoparte'
	FROM THE_X_TEAM.BI_Factura_Autoparte FA
	INNER JOIN THE_X_TEAM.BI_AUTOPARTE AP 
	on FA.ID_AUTO_PARTE = AP.ID_AUTOPARTE
	GROUP BY AP.ID_AUTOPARTE
	--ORDER BY AP.ID_AUTOPARTE
GO

CREATE VIEW THE_X_TEAM.GANANCIAS_AUTOPARTE
	AS
		SELECT DATENAME(MONTH, DATEADD(month,T.CODIGO_MES , 0 ) - 1 ) as 'Mes',
			T.CODIGO_ANIO as 'Anio',
			SUM(FA.PRECIO_FACTURADO - CA.PRECIO_COMPRA) as 'Ganancia'
		FROM THE_X_TEAM.BI_TIEMPO T
			INNER JOIN THE_X_TEAM.BI_Compra_Autoparte CA 
		on t.CODIGO_TIEMPO = ca.ID_TIEMPO
			INNER JOIN THE_X_TEAM.BI_Factura_Autoparte FA
		on CA.ID_AUTO_PARTE = FA.ID_AUTO_PARTE
		group by T.CODIGO_MES,CODIGO_ANIO
go

--Máxima cantidad de stock por cada sucursal (anual)
CREATE VIEW THE_X_TEAM.MAXIMO_STOCK_ANUAL
	AS
		SELECT SUM(a) as 'Cantidad Maxima de Stock',ANIO,SUCURSAL_DIRECCION as 'Sucursal Direccion' FROM (

SELECT 
ISNULL((SELECT SUM(CANTIDAD_AUTOPARTE) from THE_X_TEAM.COMPRA_AUTOPARTE AP 
									INNER JOIN THE_X_TEAM.Compra c
								on c.COMPRA_NRO= ap.COMPRA_NRO
								WHERE AP.AUTO_PARTE_CODIGO = ID_AUTO_PARTE 
								AND YEAR(c.COMPRA_FECHA) = T.CODIGO_ANIO
								AND S.ID_SUCURSAL = c.ID_SUCURSAL
								GROUP BY AUTO_PARTE_CODIGO),0)
								-
		isNULL((SELECT SUM(CANTIDAD_AUTOPARTE) from THE_X_TEAM.Factura_Autoparte AP
									INNER JOIN THE_X_TEAM.Factura f
								on f.FACTURA_NRO= ap.ID_FACTURA
								WHERE AP.AUTO_PARTE_CODIGO = ID_AUTO_PARTE
								AND YEAR(f.FACTURA_FECHA) = T.CODIGO_ANIO
								AND S.ID_SUCURSAL = f.ID_SUCURSAL
								GROUP BY AP.AUTO_PARTE_CODIGO),0) as a,
		T.CODIGO_ANIO as 'Anio',
		S.SUCURSAL_DIRECCION,
		S.ID_SUCURSAL
	FROM THE_X_TEAM.BI_TIEMPO T
		INNER JOIN THE_X_TEAM.BI_Compra_Autoparte CA 
	on t.CODIGO_TIEMPO = ca.ID_TIEMPO
		INNER JOIN THE_X_TEAM.BI_SUCURSAL S
	on S.ID_SUCURSAL = CA.ID_SUCURSAL
	group by T.CODIGO_TIEMPO,S.ID_SUCURSAL,ca.ID_AUTO_PARTE,T.CODIGO_ANIO,S.SUCURSAL_DIRECCION ) as a
	group by ANIO,SUCURSAL_DIRECCION
GO
