-- ==========================================================================================================================
-- =======================																				=====================
-- =======================				                SETUP DB								        =====================	
-- =======================																				=====================
-- ==========================================================================================================================


-- ---------------------------------------------------------------------------------------------------------------------------

DROP SCHEMA IF EXISTS ms CASCADE;

CREATE SCHEMA ms AUTHORIZATION massoftwareroot;	

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE EXTENSION "uuid-ossp";
-- SELECT uuid_generate_v4();

-- ---------------------------------------------------------------------------------------------------------------------------


-- ==========================================================================================================================
-- =======================				FUNCIONES UTILES												=====================	
-- ==========================================================================================================================



DROP FUNCTION IF EXISTS ms.random_between (low INT ,high INT) CASCADE;

CREATE OR REPLACE FUNCTION ms.random_between (low INT ,high INT) 
   RETURNS INT AS
$$
BEGIN
   RETURN floor(random()* (high-low + 1) + low);
END;
$$ language 'plpgsql' STRICT;


-- SELECT ms.random_between(1, 100);

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.white_is_null (att_val VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION ms.white_is_null(att_val VARCHAR) RETURNS VARCHAR AS $$
BEGIN
	IF CHAR_LENGTH(TRIM(att_val)) = 0 THEN
	
		RETURN null::VARCHAR;
	END IF;

	RETURN TRIM(att_val)::VARCHAR;
		
END;
$$  LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.zero_is_null (att_val INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION ms.zero_is_null(att_val INTEGER) RETURNS INTEGER AS $$
BEGIN
	IF att_val = 0 THEN
	
		RETURN null::INTEGER;
	END IF;

	RETURN att_val::INTEGER;
		
END;
$$  LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.zero_is_null (att_val BIGINT) CASCADE;

CREATE OR REPLACE FUNCTION ms.zero_is_null(att_val BIGINT) RETURNS BIGINT AS $$
BEGIN
	IF att_val = 0 THEN
	
		RETURN null::BIGINT;
	END IF;

	RETURN att_val::BIGINT;
		
END;
$$  LANGUAGE plpgsql;


-- ---------------------------------------------------------------------------------------------------------------------------

-- SELECT TRANSLATE('12345', '134', 'ax')

DROP FUNCTION IF EXISTS ms.translate_from () CASCADE;

CREATE OR REPLACE FUNCTION ms.translate_from() RETURNS VARCHAR AS $$
BEGIN
	
	RETURN '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'::VARCHAR;
		
END;
$$  LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

-- SELECT ms.traslate_from();

DROP FUNCTION IF EXISTS ms.translate_to () CASCADE;

CREATE OR REPLACE FUNCTION ms.translate_to() RETURNS VARCHAR AS $$
BEGIN
	
	RETURN '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'::VARCHAR;
		
END;
$$  LANGUAGE plpgsql;

-- SELECT ms.traslate_to();

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS ms.translate (att_val VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION ms.translate(att_val VARCHAR) RETURNS VARCHAR AS $$
BEGIN
	IF CHAR_LENGTH(TRIM(att_val)) = 0 THEN
	
		RETURN null::VARCHAR;
	END IF;

	RETURN TRANSLATE(att_val, ms.translate_from (), ms.translate_to())::VARCHAR;
		
END;
$$  LANGUAGE plpgsql;

-- SELECT ms.translate('1234567890' || ms.translate_from());


-- ---------------------------------------------------------------------------------------------------------------------------

/*
CREATE OR REPLACE  FUNCTION kuntur.ftg_number_admission_period_increment() RETURNS trigger AS $admission_period_increment$
    BEGIN
       
         SELECT INTO NEW.number_admission_period coalesce(MAX(number_admission_period),0) + 1 
         FROM kuntur.admission_period;
         --WHERE 	coalesce(agreement_id,'') = coalesce(NEW.agreement_id,'');
      
        RETURN NEW;
    END;
$admission_period_increment$ LANGUAGE plpgsql;

--DROP TRIGGER tg_number_batch_increment ON model.task;
CREATE TRIGGER tg_number_admission_period_increment BEFORE INSERT ON kuntur.admission_period
    FOR EACH ROW EXECUTE PROCEDURE kuntur.ftg_number_admission_period_increment();
*/