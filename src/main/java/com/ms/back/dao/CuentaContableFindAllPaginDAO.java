package com.ms.back.dao;

import java.sql.SQLException;

import com.ms.back.commons.dao.ArgsVarcharSQL;
import com.ms.back.model.Pagin;
import com.ms.back.util.persist.DataBase;
import com.ms.back.util.persist.DataBases;
import com.ms.back.util.persist.dao.ds.ex.LoadSQLTemplateDataSourceException;
import com.ms.back.util.persist.dao.ds.ex.SelectException;
import com.ms.back.util.persist.dao.ds.info.Result;
import com.ms.back.util.persist.dao.ds.info.Statement;

public class CuentaContableFindAllPaginDAO {

	public Pagin exec(String db, String pageRequest, Integer lastIndexOld, String ejercicioContableId, String por, String filtro, String op)
			throws Exception {

		// -----------------------------------------------------------------------------

		DataBase dataBase = null;

		try {

			dataBase = DataBases.connectToDataBase(db);

			return coreDao(dataBase, pageRequest, lastIndexOld, ejercicioContableId, por, filtro, op);

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

	private Pagin coreDao(DataBase dataBase, String pageRequest, Integer lastIndexOld, String ejercicioContableId,
			String por, String filtro, String op) throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		// -----------------------------------------------------------------------------

		int cantRows = count(dataBase, ejercicioContableId, por, filtro, op);
		Integer pageSize = DataBases.getDefaultPaginLimit();

		Pagin pagin = new Pagin(pageSize, cantRows, pageRequest, lastIndexOld);

		if (cantRows <= 0) {
			return pagin;
		}

		Integer limit = pagin.getPageSize(); // limit
		Integer offset = pagin.getThisPage().getIndexFrom(); // offset

		Result r = query(dataBase, limit, offset, ejercicioContableId, por, filtro, op);

		pagin.setItems(r.getTable(), r.getColumnCount());

		return pagin;

	}

	private int count(DataBase dataBase, String ejercicioContableId, String por, String filtro, String op)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementCount(ejercicioContableId, por, filtro, op);

		Result r = dataBase.query(statement);

		return (int) r.getTable()[0][0];
	}

	private Result query(DataBase dataBase, Integer limit, Integer offset, String ejercicioContableId, String por, String filtro, String op)
			throws LoadSQLTemplateDataSourceException, SelectException, SQLException {

		Statement statement = buildStatementQuery(limit, offset, ejercicioContableId, por, filtro, op);

		Result r = dataBase.query(statement);

//		for (Object[] row : r.getTable()) {
//			row[row.length - 1] = row[row.length - 1] != null && row[row.length - 1].equals("true");
//		}

		return r;

	}

	private Statement buildStatementCount(String ejercicioContableId, String por, String filtro, String op)
			throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		String andWhere = "";
		String attPor = null;

		ArgsVarcharSQL argsVarcharSQL = null;

		if (por.equals("CUENTA_CONTABLE")) {
			attPor = "CuentaContable.codigo";
			argsVarcharSQL = new ArgsVarcharSQL(op, attPor, filtro);
		} else if (por.equals("NOMBRE")) {
			attPor = "CuentaContable.nombre";
			argsVarcharSQL = new ArgsVarcharSQL(op, attPor, filtro);
		} else if (por.equals("CUENTA_AGRUPADORA")) {
			attPor = "CuentaContable.cuentaAgrupadora";
			argsVarcharSQL = new ArgsVarcharSQL(op, attPor, filtro);
		} else if (por.equals("CENTRO_DE_COSTO")) {
			attPor = "CuentaContable.centroCostoContable";
			argsVarcharSQL = new ArgsVarcharSQL(ArgsVarcharSQL.OP_EQ, attPor, filtro);
		} else if (por.equals("PUNTO_DE_EQUILIBRIO")) {
			attPor = "CuentaContable.puntoEquilibrio";
			argsVarcharSQL = new ArgsVarcharSQL(ArgsVarcharSQL.OP_EQ, attPor, filtro);
		}

		if (argsVarcharSQL != null && argsVarcharSQL.size() > 0) {
			andWhere += "\n\tAND " + argsVarcharSQL.toStringSrcs(1);
		}

		statement.setSql("SELECT\tCOUNT(*)::INTEGER\nFROM\tms.CuentaContable\n"
				+ "WHERE\tCuentaContable.ejercicioContable = ? " + andWhere);

		statement.addArg(ejercicioContableId);
		if (argsVarcharSQL != null && argsVarcharSQL.size() > 0) {
			for (String v : argsVarcharSQL.getValues()) {
				statement.addArg(v);
			}
		}

		// -----------------------------------------------------------------------------

		return statement;

	}

	private Statement buildStatementQuery(Integer limit, Integer offset, String ejercicioContableId, String por,
			String filtro, String op) throws LoadSQLTemplateDataSourceException {

		// -----------------------------------------------------------------------------

		Statement statement = new Statement();

		String andWhere = "";
		String attPor = null;

		ArgsVarcharSQL argsVarcharSQL = null;

		if (por.equals("CUENTA_CONTABLE")) {
			attPor = "CuentaContable.codigo";
			argsVarcharSQL = new ArgsVarcharSQL(op, attPor, filtro);
		} else if (por.equals("NOMBRE")) {
			attPor = "CuentaContable.nombre";
			argsVarcharSQL = new ArgsVarcharSQL(op, attPor, filtro);
		} else if (por.equals("CUENTA_AGRUPADORA")) {
			attPor = "CuentaContable.cuentaAgrupadora";
			argsVarcharSQL = new ArgsVarcharSQL(op, attPor, filtro);
		} else if (por.equals("CENTRO_DE_COSTO")) {
			attPor = "CuentaContable.centroCostoContable";
			argsVarcharSQL = new ArgsVarcharSQL(ArgsVarcharSQL.OP_EQ, attPor, filtro);
		} else if (por.equals("PUNTO_DE_EQUILIBRIO")) {
			attPor = "CuentaContable.puntoEquilibrio";
			argsVarcharSQL = new ArgsVarcharSQL(ArgsVarcharSQL.OP_EQ, attPor, filtro);
		}

		if (argsVarcharSQL != null && argsVarcharSQL.size() > 0) {
			andWhere += "\n\tAND " + argsVarcharSQL.toStringSrcs(1);
		}

		String atts = "\tCuentaContable.id," + "\n\tCuentaContable.codigo," + "\n\tCuentaContable.nombre, "
				+ "\n\tCentroCostoContable.id," + "\n\tCentroCostoContable.numero," + "\n\tCentroCostoContable.nombre, "
				+ "\n\tCuentaContable.cuentaAgrupadora," + "\n\tCuentaContable.porcentaje";

		statement.setSql("SELECT " + atts + "\nFROM\tms.CuentaContable "
				+ "\n\tLEFT JOIN ms.CentroCostoContable ON CentroCostoContable.id = CuentaContable.centroCostoContable"
				+ "\nWHERE\tCuentaContable.ejercicioContable = ?" + andWhere + "\nORDER BY " + attPor
				+ " ASC\nLIMIT ? OFFSET ?");

		statement.addArg(ejercicioContableId);
		if (argsVarcharSQL != null && argsVarcharSQL.size() > 0) {
			for (String v : argsVarcharSQL.getValues()) {
				statement.addArg(v);
			}
		}
		statement.addArg(limit);
		statement.addArg(offset);

		// -----------------------------------------------------------------------------

		return statement;

	}

}