package com.ms.back.dao;

import java.sql.SQLException;

import com.ms.back.model.Pagin;
import com.ms.back.util.persist.DataBase;
import com.ms.back.util.persist.DataBases;
import com.ms.back.util.persist.dao.ds.ex.LoadSQLTemplateDataSourceException;
import com.ms.back.util.persist.dao.ds.ex.SelectException;
import com.ms.back.util.persist.dao.ds.info.Result;
import com.ms.back.util.persist.dao.ds.info.Statement;

public class EjercicioContableFindAllPaginDAO {

	public Pagin exec(String db, String pageRequest, Integer lastIndexOld) throws Exception {

		// -----------------------------------------------------------------------------

		DataBase dataBase = null;

		try {

			dataBase = DataBases.connectToDataBase(db);

			return coreDao(dataBase, pageRequest, lastIndexOld);

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

	private Pagin coreDao(DataBase dataBase, String pageRequest, Integer lastIndexOld)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		// -----------------------------------------------------------------------------

		int cantRows = count(dataBase);
		Integer pageSize = DataBases.getDefaultPaginLimit();

		Pagin pagin = new Pagin(pageSize, cantRows, pageRequest, lastIndexOld);

		if (cantRows <= 0) {
			return pagin;
		}

		Integer limit = pagin.getPageSize(); // limit
		Integer offset = pagin.getThisPage().getIndexFrom(); // offset

		Result r = query(dataBase, limit, offset);

		pagin.setItems(r.getTable(), r.getColumnCount());

		return pagin;

	}

	private int count(DataBase dataBase) throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementCount();

		Result r = dataBase.query(statement);

		return (int) r.getTable()[0][0];
	}

	private Result query(DataBase dataBase, Integer limit, Integer offset)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementQuery(limit, offset);

		Result r = dataBase.query(statement);

//		for (Object[] row : r.getTable()) {
//			row[row.length - 1] = row[row.length - 1] != null && row[row.length - 1].equals("true");
//		}

		return r;

	}

	private Statement buildStatementCount() throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		statement.setSql("SELECT\tCOUNT(*)::INTEGER\nFROM\tms.EjercicioContable");

		// -----------------------------------------------------------------------------

		return statement;

	}

	private Statement buildStatementQuery(Integer limit, Integer offset) throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		String atts = "\tEjercicioContable.id," + "\n\tEjercicioContable.numero::VARCHAR,"
				+ "\n\tTO_CHAR(EjercicioContable.apertura :: DATE, 'dd/mm/yyyy')::VARCHAR AS apertura,"
				+ "\n\tTO_CHAR(EjercicioContable.cierre :: DATE, 'dd/mm/yyyy')::VARCHAR AS cierre, "
				+ "\n\tCASE WHEN EjercicioContable.cerrado = true  THEN 'Si'::VARCHAR ELSE ''::VARCHAR END AS cerrado, "
				+ "\n\tCASE WHEN EjercicioContable.cerradoModulos = true THEN  'Si'::VARCHAR ELSE ''::VARCHAR END AS cerradoModulos, "
				+ "\n\t CASE WHEN (Empresa.ejercicioContable IS NOT NULL) = true THEN  'Si'::VARCHAR ELSE ''::VARCHAR END AS principal ";

		statement.setSql("SELECT " + atts + "\nFROM\tms.EjercicioContable "
				+ "\n\tLEFT JOIN ( SELECT ejercicioContable FROM ms.Empresa LIMIT 1) AS Empresa ON Empresa.ejercicioContable = EjercicioContable.id\n"
				+ "\nORDER BY EjercicioContable.numero DESC\nLIMIT ? OFFSET ?");

		statement.addArg(limit);
		statement.addArg(offset);

		// -----------------------------------------------------------------------------

		return statement;

	}

}