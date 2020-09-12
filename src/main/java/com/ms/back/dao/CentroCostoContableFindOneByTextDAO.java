package com.ms.back.dao;

import java.sql.SQLException;

import javax.json.JsonObject;

import com.ms.back.commons.dao.ArgsVarcharSQL;
import com.ms.back.commons.json.JsonObjectWrapper;
import com.ms.back.util.persist.DataBase;
import com.ms.back.util.persist.DataBases;
import com.ms.back.util.persist.dao.ds.ex.LoadSQLTemplateDataSourceException;
import com.ms.back.util.persist.dao.ds.ex.SelectException;
import com.ms.back.util.persist.dao.ds.info.Result;
import com.ms.back.util.persist.dao.ds.info.Statement;

public class CentroCostoContableFindOneByTextDAO {

	public JsonObject exec(String db, String text, String ejercicioContableId) throws Exception {

		// -----------------------------------------------------------------------------

		DataBase dataBase = null;

		try {

			dataBase = DataBases.connectToDataBase(db);

			return coreDao(dataBase, text, ejercicioContableId);

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

	private JsonObject coreDao(DataBase dataBase, String text, String ejercicioContableId)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		// -----------------------------------------------------------------------------

		Result r = query(dataBase, text, ejercicioContableId);

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

	private Result query(DataBase dataBase, String text, String ejercicioContableId)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementQuery(text, ejercicioContableId);

		Result r = dataBase.query(statement);

//		for (Object[] row : r.getTable()) {
//			row[row.length - 1] = row[row.length - 1] != null && row[row.length - 1].equals("true");
//		}

		return r;

	}

	private Statement buildStatementQuery(String text, String ejercicioContableId)
			throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		Integer numero = null;
		String nombre = null;

		try {
			numero = Integer.parseInt(text);
		} catch (NumberFormatException e) {
			nombre = text;
		}

		String where = "";
		statement.addArg(ejercicioContableId);

		if (numero != null) {
			where += "\n\tAND numero = ?";
			statement.addArg(numero);
		} else {
			ArgsVarcharSQL f = new ArgsVarcharSQL(ArgsVarcharSQL.OP_C_ICT_A, "nombre", nombre);
			if (f.size() > 0) {
				where += "\n\tAND " + f.toStringSrcs(1);
				for (String v : f.getValues()) {
					statement.addArg(v);
				}
			}
		}

		statement.setSql(
				"SELECT\tid\n\t, coalesce(numero::VARCHAR, '')::VARCHAR || ' - ' || coalesce(nombre, '')::VARCHAR"
				+ "\nFROM\tms.CentroCostoContable"
				+ "\nWHERE\tejercicioContable = ? "
						+ where);

		// -----------------------------------------------------------------------------

		return statement;

	}

}