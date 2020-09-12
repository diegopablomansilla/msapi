package com.ms.back.dao;

import java.sql.SQLException;

import javax.json.JsonArray;

import com.ms.back.commons.json.JsonArrayWrapper;
import com.ms.back.util.persist.DataBase;
import com.ms.back.util.persist.DataBases;
import com.ms.back.util.persist.dao.ds.ex.LoadSQLTemplateDataSourceException;
import com.ms.back.util.persist.dao.ds.ex.SelectException;
import com.ms.back.util.persist.dao.ds.info.Result;
import com.ms.back.util.persist.dao.ds.info.Statement;

public class TipoPuntoEquilibrioFindAllDAO {

	public JsonArray exec(String db) throws Exception {

		// -----------------------------------------------------------------------------

		DataBase dataBase = null;

		try {

			dataBase = DataBases.connectToDataBase(db);

			return coreDao(dataBase);

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

	private JsonArray coreDao(DataBase dataBase)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		// -----------------------------------------------------------------------------

		Result r = query(dataBase);

		if (r.getRowCount() > 0) {
			JsonArrayWrapper ja = new JsonArrayWrapper();
			ja.addTable(r.getTable());

			return ja.build();
		}

		return null;
	}

	private Result query(DataBase dataBase) throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementQuery();

		Result r = dataBase.query(statement);

//		for (Object[] row : r.getTable()) {
//			row[row.length - 1] = row[row.length - 1] != null && row[row.length - 1].equals("true");
//		}

		return r;

	}

	private Statement buildStatementQuery() throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		String atts = "\tid\n\t, coalesce(numero::VARCHAR, '')::VARCHAR || ' - ' || coalesce(nombre, '')::VARCHAR";

		statement.setSql("SELECT " + atts + "\nFROM\tms.TipoPuntoEquilibrio\nORDER BY TipoPuntoEquilibrio.numero");

		// -----------------------------------------------------------------------------

		return statement;

	}

}