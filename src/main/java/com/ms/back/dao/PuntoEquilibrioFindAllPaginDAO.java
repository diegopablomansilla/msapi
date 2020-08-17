package com.ms.back.dao;

import java.sql.SQLException;

import com.ms.back.model.Pagin;
import com.ms.back.util.persist.DataBase;
import com.ms.back.util.persist.DataBases;
import com.ms.back.util.persist.dao.ds.ex.LoadSQLTemplateDataSourceException;
import com.ms.back.util.persist.dao.ds.ex.SelectException;
import com.ms.back.util.persist.dao.ds.info.Result;
import com.ms.back.util.persist.dao.ds.info.Statement;

public class PuntoEquilibrioFindAllPaginDAO {

	public Pagin exec(String db, String pageRequest, Integer lastIndexOld, Integer ejercicioContableId)
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

	private Pagin coreDao(DataBase dataBase, String pageRequest, Integer lastIndexOld, Integer ejercicioContableId)
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

	private int count(DataBase dataBase, Integer ejercicioContableId)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementCount(ejercicioContableId);

		Result r = dataBase.query(statement);

		return (int) r.getTable()[0][0];
	}

	private Result query(DataBase dataBase, Integer limit, Integer offset, Integer ejercicioContableId)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementQuery(limit, offset, ejercicioContableId);

		Result r = dataBase.query(statement);

//		for (Object[] row : r.getTable()) {
//			row[row.length - 1] = row[row.length - 1] != null && row[row.length - 1].equals("true");
//		}

		return r;

	}

	private Statement buildStatementCount(Integer ejercicioContableId) throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		statement.setSql("SELECT\tCOUNT(*)::INTEGER\nFROM\tms.PuntoEquilibrio\n"
				+ "WHERE\tPuntoEquilibrio.ejercicioContable = ?");
		statement.addArg(ejercicioContableId);

		// -----------------------------------------------------------------------------

		return statement;

	}

	private Statement buildStatementQuery(Integer limit, Integer offset, Integer ejercicioContableId)
			throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		String atts = "\tPuntoEquilibrio.id," + "\n\tPuntoEquilibrio.numero::VARCHAR," + "\n\tPuntoEquilibrio.nombre, "
				+ "\n\tTipoPuntoEquilibrio.id," + "\n\tTipoPuntoEquilibrio.numero::VARCHAR,"
				+ "\n\tTipoPuntoEquilibrio.nombre";

		statement.setSql("SELECT " + atts + "\nFROM\tms.PuntoEquilibrio "
				+ "\n\tLEFT JOIN ms.TipoPuntoEquilibrio ON TipoPuntoEquilibrio.id = PuntoEquilibrio.tipoPuntoEquilibrio\n"
				+ "WHERE\tPuntoEquilibrio.ejercicioContable = ?\nORDER BY PuntoEquilibrio.numero\nLIMIT ? OFFSET ?");

		statement.addArg(ejercicioContableId);
		statement.addArg(limit);
		statement.addArg(offset);

		// -----------------------------------------------------------------------------

		return statement;

	}

}