package com.ms.back.dao;

import java.sql.SQLException;

import javax.json.JsonObject;

import com.ms.back.commons.json.JsonObjectWrapper;
import com.ms.back.util.persist.DataBase;
import com.ms.back.util.persist.DataBases;
import com.ms.back.util.persist.dao.ds.ex.LoadSQLTemplateDataSourceException;
import com.ms.back.util.persist.dao.ds.ex.SelectException;
import com.ms.back.util.persist.dao.ds.info.Result;
import com.ms.back.util.persist.dao.ds.info.Statement;

public class EjercicioContableFindOneByTextDAO {

	public JsonObject exec(String db, Integer numero) throws Exception {

		// -----------------------------------------------------------------------------

		DataBase dataBase = null;

		try {

			dataBase = DataBases.connectToDataBase(db);

			return coreDao(dataBase, numero);

			// ------------------------------------------------------------------------

		} catch (Exception e) {
			throw e;
		} finally {
			try {
				if (dataBase != null) {
					dataBase.disconnect();
				}
			} catch (Exception e) {
				throw e;
			}
		}

	}

	private JsonObject coreDao(DataBase dataBase, Integer numero)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		// -----------------------------------------------------------------------------

		Result r = query(dataBase, numero);

		if (r.getTable().length == 1 && r.getTable()[0].length == 2) {

			JsonObjectWrapper j = new JsonObjectWrapper();

			Object id = r.getTable()[0][0];
			
			if (id != null && id.toString().trim().length() > 0) {
				j.set("id", id.toString().trim());
			}

			Object desc = r.getTable()[0][1];
			
			if (desc != null && desc.toString().trim().length() > 0) {
				j.set("desc", desc.toString().trim());
			}

			return j.build();
		}

		return null;
	}

	private Result query(DataBase dataBase, Integer numero) throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementQuery(numero);

		Result r = dataBase.query(statement);

//		for (Object[] row : r.getTable()) {
//			row[row.length - 1] = row[row.length - 1] != null && row[row.length - 1].equals("true");
//		}

		return r;

	}

	private Statement buildStatementQuery(Integer numero) throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();		

		statement.setSql("SELECT\tid\n\t, numero::VARCHAR\nFROM\tms.EjercicioContable\nWHERE\tnumero = ?");
		
		statement.addArg(numero);

		// -----------------------------------------------------------------------------

		return statement;

	}

}