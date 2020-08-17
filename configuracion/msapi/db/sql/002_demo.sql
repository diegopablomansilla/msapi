DELETE FROM ms.Empresa;
DELETE FROM ms.Usuario;
DELETE FROM ms.SeguridadPuerta;
DELETE FROM ms.SeguridadModulo;
DELETE FROM ms.CentroCostoContable; 
DELETE FROM ms.PuntoEquilibrio; 
DELETE FROM ms.TipoPuntoEquilibrio; 
DELETE FROM ms.CuentaContable;
DELETE FROM ms.CostoVenta;
DELETE FROM ms.AsientoModelo;
DELETE FROM ms.EjercicioContable; 
DELETE FROM ms.TipoSucursal; 
DELETE FROM ms.Sucursal; 
DELETE FROM ms.TipoComprobanteConcepto; 
DELETE FROM ms.TipoComprobanteClase; 
DELETE FROM ms.TipoComprobante; 
DELETE FROM ms.Factura; 
DELETE FROM ms.MinutaContable; 
DELETE FROM ms.AsientoContableModulo; 

-- -----------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------


INSERT INTO ms.TipoPuntoEquilibrio(id, numero, nombre) VALUES ('2', 2, 'Costos de ventas');
INSERT INTO ms.TipoPuntoEquilibrio(id, numero, nombre) VALUES ('3', 3, 'Utilidad bruta');
INSERT INTO ms.TipoPuntoEquilibrio(id, numero, nombre) VALUES ('4', 4, 'Resultados por sección');
INSERT INTO ms.TipoPuntoEquilibrio(id, numero, nombre) VALUES ('5', 5, 'Resultados operativos');
INSERT INTO ms.TipoPuntoEquilibrio(id, numero, nombre) VALUES ('6', 6, 'Resultados del periodo');

-- -----------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------

INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('1', 1,'Administrador');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('18', 18,'Adrian');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('23', 23,'Ana');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('22', 22,'BossiA');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('5', 5,'Caja Sandra');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('12', 12,'Carina');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('21', 21,'Carla');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('35', 35,'Carlos');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('49', 49,'Dario');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('4', 4,'Debitos Marcela');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('39', 39,'Edgar');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('30', 30,'Eduardo');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('44', 44,'Esteban');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('6', 6,'Fabiana');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('40', 40,'Florencia');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('37', 37,'Franco');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('19', 19,'GornoL');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('31', 31,'Jesica');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('52', 52,'Jesicap');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('25', 25,'Laura');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('28', 28,'Lelia');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('34', 34,'Lorena');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('13', 13,'Lucia');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('45', 45,'Luciano');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('51', 51,'Majo');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('2', 2,'Marcela');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('50', 50,'MarcelaN');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('27', 27,'Marcelo');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('53', 53,'Marcos');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('29', 29,'María José');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('46', 46,'MariaL');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('42', 42,'Mariano');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('43', 43,'Mariela');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('15', 15,'Natalia');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('20', 20,'NicolettiC');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('16', 16,'No Usar Ex Silvia');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('41', 41,'Noel');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('14', 14,'Pablo');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('24', 24,'Paula');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('33', 33,'Ramiro');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('38', 38,'Ricardo');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('26', 26,'Roldan');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('32', 32,'Sabrina');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('3', 3,'Sandra');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('8', 8,'SandraRecibos');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('17', 17,'Sergio');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('9', 9,'Silvana');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('36', 36,'SilvanaRecibos');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('11', 11,'Silvia');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('47', 47,'Silvina');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('7', 7,'Vetaro');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('48', 48,'VetaroRIII');
INSERT INTO ms.Usuario(id, numero, nombre) VALUES ('10', 10,'Vipecor');

-- -----------------------------------------------------------------------------------------------------------

INSERT INTO ms.SeguridadModulo (id, numero, nombre) VALUES ('3',3,'Administrador');
INSERT INTO ms.SeguridadModulo (id, numero, nombre) VALUES ('5',5,'Compras');
INSERT INTO ms.SeguridadModulo (id, numero, nombre) VALUES ('7',7,'Devolucion y Garantía');
INSERT INTO ms.SeguridadModulo (id, numero, nombre) VALUES ('2',2,'Fondos');
INSERT INTO ms.SeguridadModulo (id, numero, nombre) VALUES ('6',6,'Stock');
INSERT INTO ms.SeguridadModulo (id, numero, nombre) VALUES ('1',1,'Taba SoftWare');
INSERT INTO ms.SeguridadModulo (id, numero, nombre) VALUES ('4',4,'Ventas');

-- -----------------------------------------------------------------------------------------------------------

INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('9',9,'Responsables de Fondos-9','eD_00000009','2');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('10',10,'Parametros Generales-10','eD_00000010','3');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('12',12,'Consiliacion Bancaria-12','eD_00000012','2');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('13',13,'Responsables de Ventas-13','eD_00000013','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('14',14,'Comprobantes de Facturación-14','eD_00000014','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('15',15,'Mantenimiento de Precios-15','eD_00000015','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('16',16,'Productos - Mantenimineto-16','eD_00000016','6');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('17',17,'Mantenimiento de Clientes-17','eD_00000017','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('18',18,'Comprobantes de Facturación-18','eD_00000018','5');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('19',19,'Responsables de Compras-19','eD_00000019','5');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('20',20,'Mantenmiento de Proveedores-20','eD_00000020','5');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('21',21,'Comprobantes de Stock-21','eD_00000021','6');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('22',22,'Responsable de Stock-22','eD_00000022','6');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('25',25,'Tipos de Comprobantes-25','eD_00000025','3');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('26',26,'Talonarios-26','eD_00000026','3');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('27',27,'Visualizar Comprobantes-27','eD_00000027','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('28',28,'Productos - Modificar-28','eD_00000028','6');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('30',30,'Credito Esp-30','eD_00000030','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('31',31,'Alicuotas-31','eD_00000031','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('32',32,'Rubro y Grupos-32','eD_00000032','6');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('33',33,'Limite de credito-33','eD_00000033','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('34',34,'Cierre Ventas-34','eD_00000034','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('35',35,'Cierre Fondos-35','eD_00000035','2');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('36',36,'Cierre Compras-36','eD_00000036','5');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('37',37,'JD-37','eD_00000037','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('38',38,'Comprobantes JD-38','eD_00000038','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('39',39,'Comprobantes JD RIII-39','eD_00000039','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('40',40,'Remito Garantía-40','eD_00000040','4');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('41',41,'mantenimiento precio de costo-41','eD_00000041','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('42',42,'consulta de precio de costo-42','eD_00000042','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2001',2001,'Seguridad-2001','Pg_Seguridad','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2002',2002,'Centralizador-2002','Pg_Centralizador','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2003',2003,'Compras-2003','Pg_Compras','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2004',2004,'Contabilidad-2004','Pg_Contabilidad','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2005',2005,'Fondos-2005','Pg_Fondos','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2006',2006,'Stock-2006','Pg_Stock','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2007',2007,'Recursos Humanos-2007','Pg_RecursosHumanos','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2008',2008,'Ventas-2008','Pg_Ventas','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2026',2026,'ISO 9001-2026','Pg_ISO9001','1');
INSERT INTO ms.SeguridadPuerta (id, numero, nombre, equate, seguridadModulo) VALUES ('2028',2028,'Devoluciones y Garantías-2028','Pg_DevGtias','1');

-- -----------------------------------------------------------------------------------------------------------

INSERT INTO ms.EjercicioContable(id, numero, apertura, cierre, cerrado, cerradomodulos, comentario) VALUES ('2016',2016,'2015-03-01','2016-02-28',false,false,null);

-- -----------------------------------------------------------------------------------------------------------

INSERT INTO ms.Empresa (id, ejercicioContable) VALUES ('1', '2016');

-- -----------------------------------------------------------------------------------------------------------

INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('1-2016', 1, 'cc1', 'cc1', '2016');
INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('2-2016', 2, 'cc2', 'cc2', '2016');
INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('3-2016', 3, 'cc3', 'cc3', '2016');
INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('4-2016', 4, 'cc4', 'cc4', '2016');
INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('5-2016', 5, 'cc5', 'cc5', '2016');
INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('6-2016', 6, 'cc6', 'cc6', '2016');
INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('7-2016', 7, 'cc7', 'cc7', '2016');
INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('8-2016', 8, 'cc8', 'cc8', '2016');
INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('9-2016', 9, 'cc9', 'cc9', '2016');
INSERT INTO ms.CentroCostoContable(id, numero, nombre, abreviatura, ejerciciocontable) VALUES ('10-2016', 10, 'cc10', 'cc10', '2016');



-- -----------------------------------------------------------------------------------------------------------

INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('1-2016', 1, 'pp1', '4', '2016');
INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('2-2016', 2, 'pp2', '6', '2016');
INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('3-2016', 3, 'pp3', '3', '2016');
INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('4-2016', 4, 'pp4', '2', '2016');
INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('5-2016', 5, 'pp5', '2', '2016');
INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('6-2016', 6, 'pp6', '5', '2016');
INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('7-2016', 7, 'pp7', '4', '2016');
INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('8-2016', 8, 'pp8', '6', '2016');
INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('9-2016', 9, 'pp9', '3', '2016');
INSERT INTO ms.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejerciciocontable) VALUES ('10-2016', 10, 'pp10', '4', '2016');


-- -----------------------------------------------------------------------------------------------------------

INSERT INTO ms.CostoVenta (id, numero, nombre) VALUES ('1',1,'No participa');
INSERT INTO ms.CostoVenta (id, numero, nombre) VALUES ('2',2,'Stock');
INSERT INTO ms.CostoVenta (id, numero, nombre) VALUES ('3',3,'Compras');
INSERT INTO ms.CostoVenta (id, numero, nombre) VALUES ('4',4,'Gastos');




