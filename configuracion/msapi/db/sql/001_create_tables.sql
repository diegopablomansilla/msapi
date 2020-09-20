-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Pais                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.Pais
-- Paises
-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.Pais CASCADE;

CREATE TABLE ms.Pais
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº País
	numero INTEGER NOT NULL  CONSTRAINT Pais_numero_chk CHECK ( numero >= 1  ), 
	
	-- Abreviatura
	abreviatura VARCHAR(3) NOT NULL,
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL			
	
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Pais_0 ON ms.Pais (numero);

CREATE UNIQUE INDEX u_Pais_1 ON ms.Pais (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Pais_2 ON ms.Pais (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatPais() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatPais() RETURNS TRIGGER AS $formatPais$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.abreviatura := ms.white_is_null(NEW.abreviatura);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatPais$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPais ON ms.Pais CASCADE;

CREATE TRIGGER tgFormatPais BEFORE INSERT OR UPDATE
	ON ms.Pais FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatPais();
	
	
-- SELECT COUNT(*) FROM ms.Pais;

-- SELECT * FROM ms.Pais LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.Pais;

-- SELECT * FROM ms.Pais WHERE id = 'xxx';
















-- ---------------------------------------------------------------------------------------------------------------------------

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- Table: ms.Provincia
-- Provincias

DROP TABLE IF EXISTS ms.Provincia CASCADE;

CREATE TABLE ms.Provincia
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº provincia
	numero INTEGER NOT NULL  CONSTRAINT Provincia_numero_chk CHECK ( numero >= 1  ), 
	
	-- Abreviatura
	abreviatura VARCHAR(3) NOT NULL, 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 		
	
	-- Nº provincia AFIP
	numeroAFIP INTEGER CONSTRAINT Provincia_numeroAFIP_chk CHECK ( numeroAFIP >= 1  ), 
	
	-- Nº provincia ingresos brutos
	numeroIngresosBrutos INTEGER CONSTRAINT Provincia_numeroIngresosBrutos_chk CHECK ( numeroIngresosBrutos >= 1  ), 
	
	-- Nº provincia RENATEA
	numeroRENATEA INTEGER CONSTRAINT Provincia_numeroRENATEA_chk CHECK ( numeroRENATEA >= 1  ), 
	
	-- País
	pais VARCHAR(36)  NOT NULL  REFERENCES ms.Pais (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------

CREATE UNIQUE INDEX u_Provincia_0 ON ms.Provincia (numero);

CREATE UNIQUE INDEX u_Provincia_1 ON ms.Provincia (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Provincia_2 ON ms.Provincia (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatProvincia() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatProvincia() RETURNS TRIGGER AS $formatProvincia$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);
	 NEW.abreviatura := ms.white_is_null(NEW.abreviatura);
	 NEW.pais := ms.white_is_null(NEW.pais);

	RETURN NEW;
END;
$formatProvincia$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatProvincia ON ms.Provincia CASCADE;

CREATE TRIGGER tgFormatProvincia BEFORE INSERT OR UPDATE
	ON ms.Provincia FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatProvincia();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM ms.Provincia;

-- SELECT * FROM ms.Provincia LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.Provincia;

-- SELECT * FROM ms.Provincia WHERE id = 'xxx';











-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.Ciudad
-- Ciudades
-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.Ciudad CASCADE;

CREATE TABLE ms.Ciudad
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº ciudad
	numero INTEGER NOT NULL  CONSTRAINT Ciudad_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Departamento
	departamento VARCHAR(50),         
	
	-- Nº provincia AFIP
	numeroAFIP INTEGER CONSTRAINT Ciudad_numeroAFIP_chk CHECK ( numeroAFIP >= 1  ), 
	
	-- Provincia
	provincia VARCHAR(36)  NOT NULL  REFERENCES ms.Provincia (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------

CREATE UNIQUE INDEX u_Ciudad_0 ON ms.Ciudad (numero);

CREATE UNIQUE INDEX u_Ciudad_1 ON ms.Ciudad (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatCiudad() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatCiudad() RETURNS TRIGGER AS $formatCiudad$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);
	 NEW.departamento := ms.white_is_null(NEW.departamento);
	 NEW.provincia := ms.white_is_null(NEW.provincia);

	RETURN NEW;
END;
$formatCiudad$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCiudad ON ms.Ciudad CASCADE;

CREATE TRIGGER tgFormatCiudad BEFORE INSERT OR UPDATE
	ON ms.Ciudad FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatCiudad();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM ms.Ciudad;

-- SELECT * FROM ms.Ciudad LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.Ciudad;

-- SELECT * FROM ms.Ciudad WHERE id = 'xxx';


-- ---------------------------------------------------------------------------------------------------------------------------


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Usuario                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- Table: ms.Usuario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.Usuario CASCADE;

CREATE TABLE ms.Usuario
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº usuario
	numero INTEGER NOT NULL  CONSTRAINT Usuario_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Usuario_0 ON ms.Usuario (numero);

CREATE UNIQUE INDEX u_Usuario_1 ON ms.Usuario (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatUsuario() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatUsuario() RETURNS TRIGGER AS $formatUsuario$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatUsuario$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatUsuario ON ms.Usuario CASCADE;

CREATE TRIGGER tgFormatUsuario BEFORE INSERT OR UPDATE
	ON ms.Usuario FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatUsuario();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.Usuario;

-- SELECT * FROM ms.Usuario LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.Usuario;

-- SELECT * FROM ms.Usuario WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadModulo                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.SeguridadModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.SeguridadModulo CASCADE;

CREATE TABLE ms.SeguridadModulo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº módulo
	numero INTEGER NOT NULL  CONSTRAINT SeguridadModulo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_SeguridadModulo_0 ON ms.SeguridadModulo (numero);

CREATE UNIQUE INDEX u_SeguridadModulo_1 ON ms.SeguridadModulo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatSeguridadModulo() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatSeguridadModulo() RETURNS TRIGGER AS $formatSeguridadModulo$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatSeguridadModulo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSeguridadModulo ON ms.SeguridadModulo CASCADE;

CREATE TRIGGER tgFormatSeguridadModulo BEFORE INSERT OR UPDATE
	ON ms.SeguridadModulo FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatSeguridadModulo();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.SeguridadModulo;

-- SELECT * FROM ms.SeguridadModulo LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.SeguridadModulo;

-- SELECT * FROM ms.SeguridadModulo WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadPuerta                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.SeguridadPuerta

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.SeguridadPuerta CASCADE;

CREATE TABLE ms.SeguridadPuerta
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº módulo
	numero INTEGER NOT NULL  CONSTRAINT SeguridadPuerta_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- I.D
	equate VARCHAR(30) NOT NULL, 
	
	-- Módulo
	seguridadModulo VARCHAR(36)  NOT NULL  REFERENCES ms.SeguridadModulo (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------

/*
CREATE UNIQUE INDEX u_SeguridadPuerta_0 ON ms.SeguridadPuerta (seguridadModulo, numero);

CREATE UNIQUE INDEX u_SeguridadPuerta_1 ON ms.SeguridadPuerta (seguridadModulo, TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
*/

CREATE UNIQUE INDEX u_SeguridadPuerta_0 ON ms.SeguridadPuerta (numero);

CREATE UNIQUE INDEX u_SeguridadPuerta_1 ON ms.SeguridadPuerta (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatSeguridadPuerta() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatSeguridadPuerta() RETURNS TRIGGER AS $formatSeguridadPuerta$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);
	 NEW.equate := ms.white_is_null(NEW.equate);
	 NEW.seguridadModulo := ms.white_is_null(NEW.seguridadModulo);

	RETURN NEW;
END;
$formatSeguridadPuerta$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSeguridadPuerta ON ms.SeguridadPuerta CASCADE;

CREATE TRIGGER tgFormatSeguridadPuerta BEFORE INSERT OR UPDATE
	ON ms.SeguridadPuerta FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatSeguridadPuerta();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.SeguridadPuerta;

-- SELECT * FROM ms.SeguridadPuerta LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.SeguridadPuerta;

-- SELECT * FROM ms.SeguridadPuerta WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoSucursal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.TipoSucursal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.TipoSucursal CASCADE;

CREATE TABLE ms.TipoSucursal
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  CONSTRAINT TipoSucursal_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoSucursal_0 ON ms.TipoSucursal (numero);

CREATE UNIQUE INDEX u_TipoSucursal_1 ON ms.TipoSucursal (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatTipoSucursal() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatTipoSucursal() RETURNS TRIGGER AS $formatTipoSucursal$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoSucursal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoSucursal ON ms.TipoSucursal CASCADE;

CREATE TRIGGER tgFormatTipoSucursal BEFORE INSERT OR UPDATE
	ON ms.TipoSucursal FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatTipoSucursal();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.TipoSucursal;

-- SELECT * FROM ms.TipoSucursal LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.TipoSucursal;

-- SELECT * FROM ms.TipoSucursal WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Sucursal                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.Sucursal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.Sucursal CASCADE;

CREATE TABLE ms.Sucursal
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº sucursal
	numero INTEGER NOT NULL  CONSTRAINT Sucursal_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Tipo sucursal
	tipoSucursal VARCHAR(36)  NOT NULL  REFERENCES ms.TipoSucursal (id), 
	
	-- Cuenta clientes desde
	cuentaClientesDesde VARCHAR(7), 
	
	-- Cuenta clientes hasta
	cuentaClientesHasta VARCHAR(7), 
	
	-- Cantidad caracteres clientes
	cantidadCaracteresClientes INTEGER NOT NULL  CONSTRAINT Sucursal_cantidadCaracteresClientes_chk CHECK ( cantidadCaracteresClientes >= 3 AND cantidadCaracteresClientes <= 6  ), 
	
	-- Identificacion numérica clientes
	identificacionNumericaClientes BOOLEAN NOT NULL, 
	
	-- Permite cambiar clientes
	permiteCambiarClientes BOOLEAN NOT NULL, 
	
	-- Cuenta proveedores desde
	cuentaProveedoresDesde VARCHAR(7), 
	
	-- Cuenta proveedores hasta
	cuentaProveedoresHasta VARCHAR(7), 
	
	-- Cantidad caracteres proveedores
	cantidadCaracteresProveedores INTEGER NOT NULL  CONSTRAINT Sucursal_cantidadCaracteresProveedores_chk CHECK ( cantidadCaracteresProveedores >= 3 AND cantidadCaracteresProveedores <= 6  ), 
	
	-- Identificacion numérica proveedores
	identificacionNumericaProveedores BOOLEAN NOT NULL, 
	
	-- Permite cambiar proveedores
	permiteCambiarProveedores BOOLEAN NOT NULL, 
	
	-- Clientes ocacionales desde
	clientesOcacionalesDesde INTEGER NOT NULL  CONSTRAINT Sucursal_clientesOcacionalesDesde_chk CHECK ( clientesOcacionalesDesde >= 1  ), 
	
	-- Clientes ocacionales hasta
	clientesOcacionalesHasta INTEGER NOT NULL  CONSTRAINT Sucursal_clientesOcacionalesHasta_chk CHECK ( clientesOcacionalesHasta >= 1  ), 
	
	-- Número cobranza desde
	numeroCobranzaDesde INTEGER NOT NULL  CONSTRAINT Sucursal_numeroCobranzaDesde_chk CHECK ( numeroCobranzaDesde >= 1  ), 
	
	-- Número cobranza hasta
	numeroCobranzaHasta INTEGER NOT NULL  CONSTRAINT Sucursal_numeroCobranzaHasta_chk CHECK ( numeroCobranzaHasta >= 1  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Sucursal_0 ON ms.Sucursal (numero);

CREATE UNIQUE INDEX u_Sucursal_1 ON ms.Sucursal (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Sucursal_2 ON ms.Sucursal (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatSucursal() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatSucursal() RETURNS TRIGGER AS $formatSucursal$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);
	 NEW.abreviatura := ms.white_is_null(NEW.abreviatura);
	 NEW.tipoSucursal := ms.white_is_null(NEW.tipoSucursal);
	 NEW.cuentaClientesDesde := ms.white_is_null(NEW.cuentaClientesDesde);
	 NEW.cuentaClientesHasta := ms.white_is_null(NEW.cuentaClientesHasta);
	 NEW.cuentaProveedoresDesde := ms.white_is_null(NEW.cuentaProveedoresDesde);
	 NEW.cuentaProveedoresHasta := ms.white_is_null(NEW.cuentaProveedoresHasta);

	RETURN NEW;
END;
$formatSucursal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSucursal ON ms.Sucursal CASCADE;

CREATE TRIGGER tgFormatSucursal BEFORE INSERT OR UPDATE
	ON ms.Sucursal FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatSucursal();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.Sucursal;

-- SELECT * FROM ms.Sucursal LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.Sucursal;

-- SELECT * FROM ms.Sucursal WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: EjercicioContable                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.EjercicioContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.EjercicioContable CASCADE;

CREATE TABLE ms.EjercicioContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº ejercicio
	numero INTEGER NOT NULL  CONSTRAINT EjercicioContable_numero_chk CHECK ( numero >= 1  ), 
	
	-- Apertura
	apertura DATE NOT NULL, 
	
	-- Cierre
	cierre DATE NOT NULL, 
	
	-- Cerrado
	cerrado BOOLEAN NOT NULL, 
	
	-- Módulos cerrados
	cerradoModulos BOOLEAN NOT NULL, 
	
	-- Comentario
	comentario VARCHAR(250)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_EjercicioContable_0 ON ms.EjercicioContable (numero);

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatEjercicioContable() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatEjercicioContable() RETURNS TRIGGER AS $formatEjercicioContable$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.comentario := ms.white_is_null(NEW.comentario);

	RETURN NEW;
END;
$formatEjercicioContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatEjercicioContable ON ms.EjercicioContable CASCADE;

CREATE TRIGGER tgFormatEjercicioContable BEFORE INSERT OR UPDATE
	ON ms.EjercicioContable FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatEjercicioContable();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.EjercicioContable;

-- SELECT * FROM ms.EjercicioContable LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.EjercicioContable;

-- SELECT * FROM ms.EjercicioContable WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CentroCostoContable                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.CentroCostoContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.CentroCostoContable CASCADE;

CREATE TABLE ms.CentroCostoContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº cc
	numero INTEGER NOT NULL  CONSTRAINT CentroCostoContable_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES ms.EjercicioContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CentroCostoContable_0 ON ms.CentroCostoContable (ejercicioContable, numero);

CREATE UNIQUE INDEX u_CentroCostoContable_1 ON ms.CentroCostoContable (ejercicioContable, TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_CentroCostoContable_2 ON ms.CentroCostoContable (ejercicioContable, TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatCentroCostoContable() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatCentroCostoContable() RETURNS TRIGGER AS $formatCentroCostoContable$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);
	 NEW.abreviatura := ms.white_is_null(NEW.abreviatura);
	 NEW.ejercicioContable := ms.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatCentroCostoContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCentroCostoContable ON ms.CentroCostoContable CASCADE;

CREATE TRIGGER tgFormatCentroCostoContable BEFORE INSERT OR UPDATE
	ON ms.CentroCostoContable FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatCentroCostoContable();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.CentroCostoContable;

-- SELECT * FROM ms.CentroCostoContable LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.CentroCostoContable;

-- SELECT * FROM ms.CentroCostoContable WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoPuntoEquilibrio                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.TipoPuntoEquilibrio

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.TipoPuntoEquilibrio CASCADE;

CREATE TABLE ms.TipoPuntoEquilibrio
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  CONSTRAINT TipoPuntoEquilibrio_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoPuntoEquilibrio_0 ON ms.TipoPuntoEquilibrio (numero);

CREATE UNIQUE INDEX u_TipoPuntoEquilibrio_1 ON ms.TipoPuntoEquilibrio (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatTipoPuntoEquilibrio() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatTipoPuntoEquilibrio() RETURNS TRIGGER AS $formatTipoPuntoEquilibrio$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoPuntoEquilibrio$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoPuntoEquilibrio ON ms.TipoPuntoEquilibrio CASCADE;

CREATE TRIGGER tgFormatTipoPuntoEquilibrio BEFORE INSERT OR UPDATE
	ON ms.TipoPuntoEquilibrio FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatTipoPuntoEquilibrio();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.TipoPuntoEquilibrio;

-- SELECT * FROM ms.TipoPuntoEquilibrio LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.TipoPuntoEquilibrio;

-- SELECT * FROM ms.TipoPuntoEquilibrio WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: PuntoEquilibrio                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.PuntoEquilibrio

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.PuntoEquilibrio CASCADE;

CREATE TABLE ms.PuntoEquilibrio
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº cc
	numero INTEGER NOT NULL  CONSTRAINT PuntoEquilibrio_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Tipo
	tipoPuntoEquilibrio VARCHAR(36)  NOT NULL  REFERENCES ms.TipoPuntoEquilibrio (id), 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES ms.EjercicioContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_PuntoEquilibrio_0 ON ms.PuntoEquilibrio (ejercicioContable, numero);

CREATE UNIQUE INDEX u_PuntoEquilibrio_1 ON ms.PuntoEquilibrio (ejercicioContable, TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatPuntoEquilibrio() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatPuntoEquilibrio() RETURNS TRIGGER AS $formatPuntoEquilibrio$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);
	 NEW.tipoPuntoEquilibrio := ms.white_is_null(NEW.tipoPuntoEquilibrio);
	 NEW.ejercicioContable := ms.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatPuntoEquilibrio$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPuntoEquilibrio ON ms.PuntoEquilibrio CASCADE;

CREATE TRIGGER tgFormatPuntoEquilibrio BEFORE INSERT OR UPDATE
	ON ms.PuntoEquilibrio FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatPuntoEquilibrio();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.PuntoEquilibrio;

-- SELECT * FROM ms.PuntoEquilibrio LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.PuntoEquilibrio;

-- SELECT * FROM ms.PuntoEquilibrio WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CostoVenta                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.CostoVenta

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.CostoVenta CASCADE;

CREATE TABLE ms.CostoVenta
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  CONSTRAINT CostoVenta_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CostoVenta_0 ON ms.CostoVenta (numero);

CREATE UNIQUE INDEX u_CostoVenta_1 ON ms.CostoVenta (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatCostoVenta() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatCostoVenta() RETURNS TRIGGER AS $formatCostoVenta$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatCostoVenta$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCostoVenta ON ms.CostoVenta CASCADE;

CREATE TRIGGER tgFormatCostoVenta BEFORE INSERT OR UPDATE
	ON ms.CostoVenta FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatCostoVenta();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.CostoVenta;

-- SELECT * FROM ms.CostoVenta LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.CostoVenta;

-- SELECT * FROM ms.CostoVenta WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.CuentaContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.CuentaContable CASCADE;

CREATE TABLE ms.CuentaContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Cuenta contable
	codigo VARCHAR(30) NOT NULL, 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES ms.EjercicioContable (id), 
	
	-- Integra
	integra VARCHAR(36)  REFERENCES ms.CuentaContable (id), 
	
	-- Cuenta de jerarquia
	cuentaJerarquia VARCHAR(11) NOT NULL  CONSTRAINT CuentaContable_cuentaJerarquia_chk CHECK ( char_length(cuentaJerarquia::VARCHAR) >= 11  ), 
	
	-- Imputable
	imputable BOOLEAN NOT NULL, 
	
	-- Ajusta por inflación
	ajustaPorInflacion BOOLEAN NOT NULL, 
	
	-- Estado - cuentaEnUso
	cuentaEnUso BOOLEAN NOT NULL, 
	
	-- Cuenta con apropiación
	cuentaConApropiacion BOOLEAN NOT NULL, 
	
	-- Centro costo contable
	centroCostoContable VARCHAR(36)  REFERENCES ms.CentroCostoContable (id), 
	
	-- Cuenta agrupadora
	cuentaAgrupadora VARCHAR(50), 
	
	-- Porcentaje
	porcentaje DOUBLE PRECISION, 
	
	-- Punto de equilibrio
	puntoEquilibrio VARCHAR(36)  REFERENCES ms.PuntoEquilibrio (id), 
	
	-- Costo de venta
	costoVenta VARCHAR(36)  REFERENCES ms.CostoVenta (id), 
	
	-- Puerta
	seguridadPuerta VARCHAR(36)  REFERENCES ms.SeguridadPuerta (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CuentaContable_0 ON ms.CuentaContable (ejercicioContable, TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_CuentaContable_1 ON ms.CuentaContable (ejercicioContable, TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_CuentaContable_2 ON ms.CuentaContable (ejercicioContable, integra, cuentaJerarquia);

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatCuentaContable() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatCuentaContable() RETURNS TRIGGER AS $formatCuentaContable$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.codigo := ms.white_is_null(NEW.codigo);
	 NEW.nombre := ms.white_is_null(NEW.nombre);
	 NEW.ejercicioContable := ms.white_is_null(NEW.ejercicioContable);
	 NEW.integra := ms.white_is_null(NEW.integra);
	 NEW.cuentaJerarquia := ms.white_is_null(NEW.cuentaJerarquia);
	 NEW.centroCostoContable := ms.white_is_null(NEW.centroCostoContable);
	 NEW.cuentaAgrupadora := ms.white_is_null(NEW.cuentaAgrupadora);
	 NEW.puntoEquilibrio := ms.white_is_null(NEW.puntoEquilibrio);
	 NEW.costoVenta := ms.white_is_null(NEW.costoVenta);
	 NEW.seguridadPuerta := ms.white_is_null(NEW.seguridadPuerta);

	RETURN NEW;
END;
$formatCuentaContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaContable ON ms.CuentaContable CASCADE;

CREATE TRIGGER tgFormatCuentaContable BEFORE INSERT OR UPDATE
	ON ms.CuentaContable FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatCuentaContable();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.CuentaContable;

-- SELECT * FROM ms.CuentaContable LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.CuentaContable;

-- SELECT * FROM ms.CuentaContable WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModelo                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.AsientoModelo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.AsientoModelo CASCADE;

CREATE TABLE ms.AsientoModelo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº asiento
	numero INTEGER NOT NULL  CONSTRAINT AsientoModelo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES ms.EjercicioContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_AsientoModelo_0 ON ms.AsientoModelo (ejercicioContable, numero);

CREATE UNIQUE INDEX u_AsientoModelo_1 ON ms.AsientoModelo (ejercicioContable, TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatAsientoModelo() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatAsientoModelo() RETURNS TRIGGER AS $formatAsientoModelo$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);
	 NEW.ejercicioContable := ms.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatAsientoModelo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoModelo ON ms.AsientoModelo CASCADE;

CREATE TRIGGER tgFormatAsientoModelo BEFORE INSERT OR UPDATE
	ON ms.AsientoModelo FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatAsientoModelo();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.AsientoModelo;

-- SELECT * FROM ms.AsientoModelo LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.AsientoModelo;

-- SELECT * FROM ms.AsientoModelo WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModeloItem                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.AsientoModeloItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.AsientoModeloItem CASCADE;

CREATE TABLE ms.AsientoModeloItem
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº item
	numero INTEGER NOT NULL  CONSTRAINT AsientoModeloItem_numero_chk CHECK ( numero >= 1  ), 
	
	-- Asiento modelo
	asientoModelo VARCHAR(36)  NOT NULL  REFERENCES ms.AsientoModelo (id), 
	
	-- Cuenta contable
	cuentaContable VARCHAR(36)  NOT NULL  REFERENCES ms.CuentaContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_AsientoModeloItem_0 ON ms.AsientoModeloItem (asientoModelo, numero);

CREATE UNIQUE INDEX u_AsientoModeloItem_1 ON ms.AsientoModeloItem (asientoModelo, cuentaContable);

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatAsientoModeloItem() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatAsientoModeloItem() RETURNS TRIGGER AS $formatAsientoModeloItem$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.asientoModelo := ms.white_is_null(NEW.asientoModelo);
	 NEW.cuentaContable := ms.white_is_null(NEW.cuentaContable);

	RETURN NEW;
END;
$formatAsientoModeloItem$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoModeloItem ON ms.AsientoModeloItem CASCADE;

CREATE TRIGGER tgFormatAsientoModeloItem BEFORE INSERT OR UPDATE
	ON ms.AsientoModeloItem FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatAsientoModeloItem();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.AsientoModeloItem;

-- SELECT * FROM ms.AsientoModeloItem LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.AsientoModeloItem;

-- SELECT * FROM ms.AsientoModeloItem WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoComprobanteConcepto                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.TipoComprobanteConcepto

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.TipoComprobanteConcepto CASCADE;

CREATE TABLE ms.TipoComprobanteConcepto
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  CONSTRAINT TipoComprobanteConcepto_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL	

);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoComprobanteConcepto_0 ON ms.TipoComprobanteConcepto (numero);

CREATE UNIQUE INDEX u_TipoComprobanteConcepto_1 ON ms.TipoComprobanteConcepto (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatTipoComprobanteConcepto() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatTipoComprobanteConcepto() RETURNS TRIGGER AS $formatTipoComprobanteConcepto$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoComprobanteConcepto$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoComprobanteConcepto ON ms.TipoComprobanteConcepto CASCADE;

CREATE TRIGGER tgFormatTipoComprobanteConcepto BEFORE INSERT OR UPDATE
	ON ms.TipoComprobanteConcepto FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatTipoComprobanteConcepto();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.TipoComprobanteConcepto;

-- SELECT * FROM ms.TipoComprobanteConcepto LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.TipoComprobanteConcepto;

-- SELECT * FROM ms.TipoComprobanteConcepto WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoComprobanteClase                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.TipoComprobanteClase

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.TipoComprobanteClase CASCADE;

CREATE TABLE ms.TipoComprobanteClase
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  CONSTRAINT TipoComprobanteClase_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL,
	
	-- Stock
	stock BOOLEAN NOT NULL,

	-- Ventas
	ventas BOOLEAN NOT NULL,	
	
	-- Fondos
	fondos BOOLEAN NOT NULL,
	
	-- Compras
	compras BOOLEAN NOT NULL,
	
	-- Contabilidad
	contabilidad BOOLEAN NOT NULL,
	
	-- Devoluciones
	devoluciones BOOLEAN NOT NULL,
	
	-- Tambos
	tambos BOOLEAN NOT NULL,
	
	-- Produccion
	produccion BOOLEAN NOT NULL,
	
	-- RRHH
	rrhh BOOLEAN NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoComprobanteClase_0 ON ms.TipoComprobanteClase (numero);
/*
CREATE UNIQUE INDEX u_TipoComprobanteClase_1 ON ms.TipoComprobanteClase (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
*/
-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatTipoComprobanteClase() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatTipoComprobanteClase() RETURNS TRIGGER AS $formatTipoComprobanteClase$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoComprobanteClase$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoComprobanteClase ON ms.TipoComprobanteClase CASCADE;

CREATE TRIGGER tgFormatTipoComprobanteClase BEFORE INSERT OR UPDATE
	ON ms.TipoComprobanteClase FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatTipoComprobanteClase();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.TipoComprobanteClase;

-- SELECT * FROM ms.TipoComprobanteClase LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.TipoComprobanteClase;

-- SELECT * FROM ms.TipoComprobanteClase WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoComprobante                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.TipoComprobante

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.TipoComprobante CASCADE;

CREATE TABLE ms.TipoComprobante
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  CONSTRAINT TipoComprobante_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL,
    
    -- Nombre a imprimir
	nombreImprimir VARCHAR(50) NOT NULL,
    
    -- Abreviatura
	abreviatura VARCHAR(5) NOT NULL,
    
    -- Sucursal
	sucursal VARCHAR(36)  NOT NULL  REFERENCES ms.Sucursal (id), 
    
     -- Concepto
	tipoComprobanteConcepto VARCHAR(36)  NOT NULL  REFERENCES ms.TipoComprobanteConcepto (id), 
    
     -- Clase
	tipoComprobanteClase VARCHAR(36)  NOT NULL  REFERENCES ms.TipoComprobanteClase (id), 
    
    -- Obsoleto
	obsoleto BOOLEAN NOT NULL,
	
	-- Stock
	stock BOOLEAN NOT NULL,

	-- Ventas
	ventas BOOLEAN NOT NULL,	
	
	-- Fondos
	fondos BOOLEAN NOT NULL,
	
	-- Compras
	compras BOOLEAN NOT NULL,
	
	-- Contabilidad
	contabilidad BOOLEAN NOT NULL,
	
	-- Devoluciones
	devoluciones BOOLEAN NOT NULL,
	
	-- Tambos
	tambos BOOLEAN NOT NULL,
	
	-- Produccion
	produccion BOOLEAN NOT NULL,
	
	-- RRHH
	rrhh BOOLEAN NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoComprobante_0 ON ms.TipoComprobante (numero);

CREATE UNIQUE INDEX u_TipoComprobante_1 ON ms.TipoComprobante (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
 /*
CREATE UNIQUE INDEX u_TipoComprobante_2 ON ms.TipoComprobante (TRANSLATE(LOWER(TRIM(nombreImprimir))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));        
*/	
  /*  
CREATE UNIQUE INDEX u_TipoComprobante_3 ON ms.TipoComprobante (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));    
*/
-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatTipoComprobante() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatTipoComprobante() RETURNS TRIGGER AS $formatTipoComprobante$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoComprobante$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoComprobante ON ms.TipoComprobante CASCADE;

CREATE TRIGGER tgFormatTipoComprobante BEFORE INSERT OR UPDATE
	ON ms.TipoComprobante FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatTipoComprobante();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.TipoComprobante;

-- SELECT * FROM ms.TipoComprobante LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.TipoComprobante;

-- SELECT * FROM ms.TipoComprobante WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Factura                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.Factura

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.Factura CASCADE;

CREATE TABLE ms.Factura
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº 
	numero INTEGER NOT NULL  CONSTRAINT CostoVenta_numero_chk CHECK ( numero >= 1  ), 
    
    -- Tipo comprobante
	tipoComprobante VARCHAR(36)  NOT NULL  REFERENCES ms.TipoComprobante (id), 
    
    -- Comprobante
	comprobante VARCHAR(13) NOT NULL , 
	
	-- Fecha ingreso
	fechaIngreso TIMESTAMP NOT NULL,
    
    -- Fecha
	fecha DATE NOT NULL,
    
     -- Razon social
	razonSocial VARCHAR(100) NOT NULL , 
    
     -- Tipo identificacion
	tipoIdentificacion VARCHAR(30)  , 
    
     -- Identificacion
	identificacion VARCHAR(11) 
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Factura_0 ON ms.Factura ( tipoComprobante, numero);

CREATE UNIQUE INDEX u_Factura_1 ON ms.Factura ( TRIM(comprobante) );

CREATE UNIQUE INDEX u_Factura_2 ON ms.Factura ( tipoComprobante, numero, TRIM(comprobante) );

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatFactura() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatFactura() RETURNS TRIGGER AS $formatFactura$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.tipoComprobante := ms.white_is_null(NEW.tipoComprobante);
	 NEW.comprobante := ms.white_is_null(NEW.comprobante);
	 NEW.razonSocial := ms.white_is_null(NEW.razonSocial);
	 NEW.tipoIdentificacion := ms.white_is_null(NEW.tipoIdentificacion);
	 NEW.identificacion := ms.white_is_null(NEW.identificacion);

	RETURN NEW;
END;
$formatFactura$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatFactura ON ms.Factura CASCADE;

CREATE TRIGGER tgFormatFactura BEFORE INSERT OR UPDATE
	ON ms.Factura FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatFactura();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.Factura;

-- SELECT * FROM ms.Factura LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.Factura;

-- SELECT * FROM ms.Factura WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: FacturaPro                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.FacturaPro

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.FacturaPro CASCADE;

CREATE TABLE ms.FacturaPro
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº 
	numero INTEGER NOT NULL  CONSTRAINT CostoVenta_numero_chk CHECK ( numero >= 1  ), 
    
    -- Tipo comprobante
	tipoComprobante VARCHAR(36)  NOT NULL  REFERENCES ms.TipoComprobante (id), 
    
    -- Comprobante
	comprobante VARCHAR(13) NOT NULL , 
	
	-- Fecha ingreso
	fechaIngreso TIMESTAMP NOT NULL,
    
    -- Fecha
	fecha DATE NOT NULL,
    
     -- Razon social
	razonSocial VARCHAR(100) NOT NULL , 
    
     -- Tipo identificacion
	tipoIdentificacion VARCHAR(30)  , 
    
     -- Identificacion
	identificacion VARCHAR(11) 
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_FacturaPro_0 ON ms.FacturaPro ( tipoComprobante, numero);

-- CREATE UNIQUE INDEX u_FacturaPro_1 ON ms.FacturaPro ( TRIM(comprobante) );

CREATE UNIQUE INDEX u_FacturaPro_2 ON ms.FacturaPro ( tipoComprobante, numero, TRIM(comprobante) );

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatFacturaPro() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatFacturaPro() RETURNS TRIGGER AS $formatFacturaPro$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.tipoComprobante := ms.white_is_null(NEW.tipoComprobante);
	 NEW.comprobante := ms.white_is_null(NEW.comprobante);
	 NEW.razonSocial := ms.white_is_null(NEW.razonSocial);
	 NEW.tipoIdentificacion := ms.white_is_null(NEW.tipoIdentificacion);
	 NEW.identificacion := ms.white_is_null(NEW.identificacion);

	RETURN NEW;
END;
$formatFacturaPro$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatFacturaPro ON ms.FacturaPro CASCADE;

CREATE TRIGGER tgFormatFacturaPro BEFORE INSERT OR UPDATE
	ON ms.FacturaPro FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatFacturaPro();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.FacturaPro;

-- SELECT * FROM ms.FacturaPro LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.FacturaPro;

-- SELECT * FROM ms.FacturaPro WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Fondo                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.Fondo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.Fondo CASCADE;

CREATE TABLE ms.Fondo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº 
	numero INTEGER NOT NULL  CONSTRAINT CostoVenta_numero_chk CHECK ( numero >= 1  ), 
    
    -- Tipo comprobante
	tipoComprobante VARCHAR(36)  NOT NULL  REFERENCES ms.TipoComprobante (id), 
    
    -- Comprobante
	comprobante VARCHAR(13) NOT NULL , 
	
	-- Fecha ingreso
	fechaIngreso TIMESTAMP NOT NULL,
    
    -- Fecha
	fecha DATE NOT NULL,
    
     -- Detalle
	detalle VARCHAR(200) NOT NULL 
	
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Fondo_0 ON ms.Fondo ( tipoComprobante, numero);

-- CREATE UNIQUE INDEX u_Fondo_1 ON ms.Fondo ( TRIM(comprobante) );

CREATE UNIQUE INDEX u_Fondo_2 ON ms.Fondo ( tipoComprobante, numero, TRIM(comprobante) );

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatFondo() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatFondo() RETURNS TRIGGER AS $formatFondo$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.tipoComprobante := ms.white_is_null(NEW.tipoComprobante);
	 NEW.comprobante := ms.white_is_null(NEW.comprobante);
	 NEW.detalle := ms.white_is_null(NEW.detalle);	 

	RETURN NEW;
END;
$formatFondo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatFondo ON ms.Fondo CASCADE;

CREATE TRIGGER tgFormatFondo BEFORE INSERT OR UPDATE
	ON ms.Fondo FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatFondo();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.Fondo;

-- SELECT * FROM ms.Fondo LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.Fondo;

-- SELECT * FROM ms.Fondo WHERE id = 'xxx';



-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MinutaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.MinutaContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.MinutaContable CASCADE;

CREATE TABLE ms.MinutaContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº minuta
	numero INTEGER NOT NULL  CONSTRAINT MinutaContable_numero_chk CHECK ( numero >= 0  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MinutaContable_0 ON ms.MinutaContable (numero);

CREATE UNIQUE INDEX u_MinutaContable_1 ON ms.MinutaContable (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatMinutaContable() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatMinutaContable() RETURNS TRIGGER AS $formatMinutaContable$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatMinutaContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMinutaContable ON ms.MinutaContable CASCADE;

CREATE TRIGGER tgFormatMinutaContable BEFORE INSERT OR UPDATE
	ON ms.MinutaContable FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatMinutaContable();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.MinutaContable;

-- SELECT * FROM ms.MinutaContable LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.MinutaContable;

-- SELECT * FROM ms.MinutaContable WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableModulo                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.AsientoContableModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.AsientoContableModulo CASCADE;

CREATE TABLE ms.AsientoContableModulo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº módulo
	numero INTEGER NOT NULL  CONSTRAINT AsientoContableModulo_numero_chk CHECK ( numero >= 0  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_AsientoContableModulo_0 ON ms.AsientoContableModulo (numero);

CREATE UNIQUE INDEX u_AsientoContableModulo_1 ON ms.AsientoContableModulo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatAsientoContableModulo() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatAsientoContableModulo() RETURNS TRIGGER AS $formatAsientoContableModulo$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.nombre := ms.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatAsientoContableModulo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoContableModulo ON ms.AsientoContableModulo CASCADE;

CREATE TRIGGER tgFormatAsientoContableModulo BEFORE INSERT OR UPDATE
	ON ms.AsientoContableModulo FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatAsientoContableModulo();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.AsientoContableModulo;

-- SELECT * FROM ms.AsientoContableModulo LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.AsientoContableModulo;

-- SELECT * FROM ms.AsientoContableModulo WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContable                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.AsientoContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.AsientoContable CASCADE;

CREATE TABLE ms.AsientoContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº asiento
	numero INTEGER NOT NULL  CONSTRAINT AsientoContable_numero_chk CHECK ( numero >= 1  ), 
	
	-- Fecha
	fecha DATE NOT NULL, 
	
	-- Detalle
	detalle VARCHAR(100) NOT NULL, 
	
	-- Detalle comprobante
	detalleComprobante VARCHAR(100), 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES ms.EjercicioContable (id), 
	
	-- Minuta contable
	minutaContable VARCHAR(36)  NOT NULL  REFERENCES ms.MinutaContable (id), 
	
	-- Sucursal
	sucursal VARCHAR(36)  REFERENCES ms.Sucursal (id), 
	
	-- Módulo
	asientoContableModulo VARCHAR(36)  NOT NULL  REFERENCES ms.AsientoContableModulo (id),
	
	-- Nº lote
	lote INTEGER CONSTRAINT AsientoContable_lote_chk CHECK ( numero >= 0  ), 
	
	-- Comprobante factura
	comprobanteFactura VARCHAR(36)  REFERENCES ms.Factura (id),
	
	-- Comprobante factura pro
	comprobanteFacturaPro VARCHAR(36)  REFERENCES ms.FacturaPro (id),
	
	-- Comprobante fondo
	comprobanteFondo VARCHAR(36)  REFERENCES ms.Fondo (id)
	
	
	
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_AsientoContable_0 ON ms.AsientoContable (ejercicioContable, numero);

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatAsientoContable() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatAsientoContable() RETURNS TRIGGER AS $formatAsientoContable$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.detalle := ms.white_is_null(NEW.detalle);
	 NEW.ejercicioContable := ms.white_is_null(NEW.ejercicioContable);
	 NEW.minutaContable := ms.white_is_null(NEW.minutaContable);
	 NEW.sucursal := ms.white_is_null(NEW.sucursal);
	 NEW.asientoContableModulo := ms.white_is_null(NEW.asientoContableModulo);
	 
	 NEW.comprobanteFactura := ms.white_is_null(NEW.comprobanteFactura);
	 NEW.comprobanteFacturaPro := ms.white_is_null(NEW.comprobanteFacturaPro);
	 NEW.comprobanteFondo := ms.white_is_null(NEW.comprobanteFondo);

	RETURN NEW;
END;
$formatAsientoContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoContable ON ms.AsientoContable CASCADE;

CREATE TRIGGER tgFormatAsientoContable BEFORE INSERT OR UPDATE
	ON ms.AsientoContable FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatAsientoContable();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.AsientoContable;

-- SELECT * FROM ms.AsientoContable LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.AsientoContable;

-- SELECT * FROM ms.AsientoContable WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableItem                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.AsientoContableItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.AsientoContableItem CASCADE;

CREATE TABLE ms.AsientoContableItem
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº item
	numero INTEGER NOT NULL  CONSTRAINT AsientoContableItem_numero_chk CHECK ( numero >= 1  ), 
	
	-- Fecha
	fecha DATE NOT NULL, 
	
	-- Detalle
	detalle VARCHAR(100), 
	
	-- Asiento contable
	asientoContable VARCHAR(36)  NOT NULL  REFERENCES ms.AsientoContable (id), 
	
	-- Cuenta contable
	cuentaContable VARCHAR(36)  NOT NULL  REFERENCES ms.CuentaContable (id), 
	
	-- Debe
	debe DECIMAL(13,5) NOT NULL, 
	
	-- Haber
	haber DECIMAL(13,5) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_AsientoContableItem_0 ON ms.AsientoContableItem (asientoContable, numero);

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatAsientoContableItem() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatAsientoContableItem() RETURNS TRIGGER AS $formatAsientoContableItem$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.detalle := ms.white_is_null(NEW.detalle);
	 NEW.asientoContable := ms.white_is_null(NEW.asientoContable);
	 NEW.cuentaContable := ms.white_is_null(NEW.cuentaContable);

	RETURN NEW;
END;
$formatAsientoContableItem$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoContableItem ON ms.AsientoContableItem CASCADE;

CREATE TRIGGER tgFormatAsientoContableItem BEFORE INSERT OR UPDATE
	ON ms.AsientoContableItem FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatAsientoContableItem();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.AsientoContableItem;

-- SELECT * FROM ms.AsientoContableItem LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.AsientoContableItem;

-- SELECT * FROM ms.AsientoContableItem WHERE id = 'xxx';

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Empresa                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: ms.Empresa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS ms.Empresa CASCADE;

CREATE TABLE ms.Empresa
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES ms.EjercicioContable (id), 
	
	-- Fecha cierre ventas
	fechaCierreVentas DATE, 
	
	-- Fecha cierre stock
	fechaCierreStock DATE, 
	
	-- Fecha cierre fondo
	fechaCierreFondo DATE, 
	
	-- Fecha cierre compras
	fechaCierreCompras DATE, 
	
	-- Fecha cierre contabilidad
	fechaCierreContabilidad DATE, 
	
	-- Fecha cierre garantia y devoluciones
	fechaCierreGarantiaDevoluciones DATE, 
	
	-- Fecha cierre tambos
	fechaCierreTambos DATE, 
	
	-- Fecha cierre RRHH
	fechaCierreRRHH DATE
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.ftgFormatEmpresa() CASCADE;

CREATE OR REPLACE FUNCTION ms.ftgFormatEmpresa() RETURNS TRIGGER AS $formatEmpresa$
DECLARE
BEGIN
	 NEW.id := ms.white_is_null(NEW.id);
	 NEW.ejercicioContable := ms.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatEmpresa$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatEmpresa ON ms.Empresa CASCADE;

CREATE TRIGGER tgFormatEmpresa BEFORE INSERT OR UPDATE
	ON ms.Empresa FOR EACH ROW
	EXECUTE PROCEDURE ms.ftgFormatEmpresa();

-- ---------------------------------------------------------------------------------------------------------------------------


-- SELECT COUNT(*) FROM ms.Empresa;

-- SELECT * FROM ms.Empresa LIMIT 100 OFFSET 0;

-- SELECT * FROM ms.Empresa;

-- SELECT * FROM ms.Empresa WHERE id = 'xxx';
