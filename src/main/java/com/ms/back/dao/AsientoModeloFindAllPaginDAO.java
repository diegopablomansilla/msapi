package com.ms.back.dao;

import java.sql.SQLException;

import com.ms.back.model.Pagin;
import com.ms.back.util.persist.DataBase;
import com.ms.back.util.persist.DataBases;
import com.ms.back.util.persist.dao.ds.ex.LoadSQLTemplateDataSourceException;
import com.ms.back.util.persist.dao.ds.ex.SelectException;
import com.ms.back.util.persist.dao.ds.info.Result;
import com.ms.back.util.persist.dao.ds.info.Statement;

public class AsientoModeloFindAllPaginDAO {

	public Pagin exec(String db, String pageRequest, Integer lastIndexOld, String ejercicioContableId)
			throws Exception {

		// -----------------------------------------------------------------------------

		DataBase dataBase = null;

		try {

			dataBase = DataBases.connectToDataBase(db);

			return coreDao(dataBase, pageRequest, lastIndexOld, ejercicioContableId);

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

	private Pagin coreDao(DataBase dataBase, String pageRequest, Integer lastIndexOld, String ejercicioContableId)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		// -----------------------------------------------------------------------------

		int cantRows = count(dataBase, ejercicioContableId);
		Integer pageSize = DataBases.getDefaultPaginLimit();

		Pagin pagin = new Pagin(pageSize, cantRows, pageRequest, lastIndexOld);

		if (cantRows <= 0) {
			return pagin;
		}

		Integer limit = pagin.getPageSize(); // limit
		Integer offset = pagin.getThisPage().getIndexFrom(); // offset

		Result r = query(dataBase, limit, offset, ejercicioContableId);

		pagin.setItems(r.getTable(), r.getColumnCount());

		return pagin;

	}

	private int count(DataBase dataBase, String ejercicioContableId)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementCount(ejercicioContableId);

		Result r = dataBase.query(statement);

		return (int) r.getTable()[0][0];
	}

	private Result query(DataBase dataBase, Integer limit, Integer offset, String ejercicioContableId)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementQuery(limit, offset, ejercicioContableId);

		Result r = dataBase.query(statement);

//		for (Object[] row : r.getTable()) {
//			row[row.length - 1] = row[row.length - 1] != null && row[row.length - 1].equals("true");
//		}

		return r;

	}

	private Statement buildStatementCount(String ejercicioContableId) throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		statement.setSql(
				"SELECT\tCOUNT(*)::INTEGER\nFROM\tms.AsientoModelo\n" + "WHERE\tAsientoModelo.ejercicioContable = ?");
		statement.addArg(ejercicioContableId);

		// -----------------------------------------------------------------------------

		return statement;

	}

	private Statement buildStatementQuery(Integer limit, Integer offset, String ejercicioContableId)
			throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		String atts = "\tAsientoModelo.id," + "\n\tAsientoModelo.numero::VARCHAR," + "\n\tAsientoModelo.nombre ";

		statement.setSql("SELECT " + atts + "\nFROM\tms.AsientoModelo\nWHERE\tAsientoModelo.ejercicioContable = ?\n"
				+ "ORDER BY AsientoModelo.numero\nLIMIT ? OFFSET ?");

		statement.addArg(ejercicioContableId);
		statement.addArg(limit);
		statement.addArg(offset);

		// -----------------------------------------------------------------------------

		return statement;

	}

}