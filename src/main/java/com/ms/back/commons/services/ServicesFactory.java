package com.ms.back.commons.services;

import java.io.File;
import java.io.FileReader;
import java.net.URL;
import java.util.Properties;

import com.ms.back.EnvironmentVariables;
import com.ms.back.PrinterImpl;
import com.ms.back.services.AsientoModeloFindAllPagin;
import com.ms.back.services.CentroCostoContableFindAllPagin;
import com.ms.back.services.CentroCostoContableFindOneByText;
import com.ms.back.services.CostoVentaFindAll;
import com.ms.back.services.CuentaContableFindAllPagin;
import com.ms.back.services.EjercicioContableFindAllPagin;
import com.ms.back.services.EjercicioContableFindOneByText;
import com.ms.back.services.PuntoEquilibrioFindAllPagin;
import com.ms.back.services.PuntoEquilibrioFindOneByText;
import com.ms.back.services.TipoPuntoEquilibrioFindAll;
import com.ms.back.util.persist.DataBases;

public class ServicesFactory {

	private EnvironmentVariables vars;

	

	public ServicesFactory() {
		super();

		// "file:D:/dev/ambientes/eti/workspace/ms_back_business/files/db";

		try {

			String API_FILES = System.getenv().get("MS_API_FILES");

			if (API_FILES == null || API_FILES.trim().length() == 0) {
//				API_FILES = "D:/dev/source/msapi/configuracion/msapi";//666

				System.out.println("[ERROR] No se encontro la variable de entorno MS_API_FILES.");

				System.exit(-1);
			}

			FileReader reader = new FileReader(API_FILES + File.separatorChar + "msapi.properties");

			Properties p = new Properties();
			p.load(reader);

			vars = new EnvironmentVariables();

			vars.setHost(p.getProperty("api.host"));
			vars.setVerbose(Boolean.parseBoolean(p.getProperty("db.verbose")));
			vars.setDefaultPaginLimit(Integer.parseInt(p.getProperty("db.defaultPaginLimit")));
			vars.addDataBase(p.getProperty("db.default"));

			vars.setDataSourceURL(new URL("file:" + API_FILES + "/db/ds"));
			vars.setPpURL(new URL("file:" + API_FILES + "/db/pp"));
			vars.setSqlTemplatesURL(new URL("file:" + API_FILES + "/db/sql"));
			vars.setContents(new URL("file:" + API_FILES + "/db/contents"));

			DataBases.setup(new PrinterImpl(), vars.isVerbose(), vars.getDataSourceURL(), vars.getSqlTemplatesURL(),
					vars.getDefaultPaginLimit());

		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			System.exit(-1);
		}

	}
	
	public EnvironmentVariables getVars() {
		return vars;
	}

	public AbstractService buildService(String path, String v) {

		if (path == null) {
			return null;
		}

		path = path.trim();

		if (v.equalsIgnoreCase("GET")) {

			if ("/EjercicioContable/findAllPagin".equals(path)) {
				return new EjercicioContableFindAllPagin(vars);
			}

			if ("/EjercicioContable/findOneByText".equals(path)) {
				return new EjercicioContableFindOneByText(vars);
			}

			// ------------------------------------ -

			if ("/PuntoEquilibrio/findAllPagin".equals(path)) {
				return new PuntoEquilibrioFindAllPagin(vars);
			}

			if ("/PuntoEquilibrio/findOneByText".equals(path)) {
				return new PuntoEquilibrioFindOneByText(vars);
			}

			// ------------------------------------ -

			if ("/CentroCostoContable/findAllPagin".equals(path)) {
				return new CentroCostoContableFindAllPagin(vars);
			}

			if ("/CentroCostoContable/findOneByText".equals(path)) {
				return new CentroCostoContableFindOneByText(vars);
			}

			// ------------------------------------ -

			if ("/AsientoModelo/findAllPagin".equals(path)) {
				return new AsientoModeloFindAllPagin(vars);
			}

			if ("/CuentaContable/findAllPagin".equals(path)) {
				return new CuentaContableFindAllPagin(vars);
			}

			if ("/TipoPuntoEquilibrio/findAll".equals(path)) {
				return new TipoPuntoEquilibrioFindAll(vars);
			}

			if ("/CostoVenta/findAll".equals(path)) {
				return new CostoVentaFindAll(vars);
			}

			// --------------------------------------------------

//			if ("/EnvironmentVariables/contents".equals(path)) {
//				return new EnvironmentVariablesContents(vars);
//			}
//
//			if ("/Tarea/download".equals(path)) {
//				return new TareaDownload(vars);
//			}
//
//			if ("/Seccion/findAll".equals(path)) {
//				return new SeccionFindAll(vars);
//			}
//
//			if ("/Puesto/findAll".equals(path)) {
//				return new PuestoFindAll(vars);
//			}
//
//			if ("/Tarea/findAll".equals(path)) {
//				return new TareaFindAll(vars);
//			}
//
//			if ("/OrdenFabricacion/findAll".equals(path)) {
//				return new OrdenFabricacionFindAll(vars);
//			}
//
//			if ("/TareaPersona/findAll".equals(path)) {
//				return new TareaPersonaFindAll(vars);
//			}
//
//			if ("/MiTarea/findAll".equals(path)) {
//				return new MiTareaFindAll(vars);
//			}
//
//			if ("/MiTareaEnEjecucion/findAll".equals(path)) {
//				return new MiTareaEnEjecucionFindAll(vars);
//			}
//
//			if ("/Persona/findAll".equals(path)) {
//				return new PersonaFindAll(vars);
//			}
//
//			if ("/Calendario/findAll".equals(path)) {
//				return new CalendarioFindAll(vars);
//			}
//
//			if ("/MiTarea/findById".equals(path)) {
//				return new MiTareaFindById(vars);
//			}

		}

		if (v.equalsIgnoreCase("POST")) {

//			if ("/login".equals(path)) {
//				return new Login(vars);
//			}
//
//			if ("/Tarea/delete".equals(path)) {
//				return new TareaDelete(vars);
//			}
//
//			if ("/Tarea/create".equals(path)) {
//				return new TareaCreate(vars);
//			}
//
//			if ("/Tarea/save".equals(path)) {
//				return new TareaSave(vars);
//			}
//
//			if ("/Tarea/close".equals(path)) {
//				return new TareaClose(vars);
//			}
//
//			if ("/Calendario/create".equals(path)) {
//				return new CalendarioCreate(vars);
//			}
//
//			if ("/Calendario/save".equals(path)) {
//				return new CalendarioSave(vars);
//			}
//
//			if ("/Calendario/delete".equals(path)) {
//				return new CalendarioDelete(vars);
//			}
//
//			if ("/TareaPersona/create".equals(path)) {
//				return new TareaPersonaCreate(vars);
//			}
//
//			if ("/MiTarea/create".equals(path)) {
//				return new MiTareaCreate(vars);
//			}
//
//			if ("/MiTarea/save".equals(path)) {
//				return new MiTareaSave(vars);
//			}
		}

		return null;
	}

}
