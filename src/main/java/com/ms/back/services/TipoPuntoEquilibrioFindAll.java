package com.ms.back.services;

import java.io.PrintWriter;

import javax.json.JsonArray;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ms.back.EnvironmentVariables;
import com.ms.back.commons.services.AbstractService;
import com.ms.back.dao.TipoPuntoEquilibrioFindAllDAO;

public class TipoPuntoEquilibrioFindAll extends AbstractService {

	private TipoPuntoEquilibrioFindAllDAO dao = new TipoPuntoEquilibrioFindAllDAO();

	public TipoPuntoEquilibrioFindAll(EnvironmentVariables vars) {
		super(vars);
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// -------------------------------------------------------------------------------------

		String db = request.getHeader("db");
		if (db == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		db = db.trim();
		if (db.length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		// -------------------------------------------------------------------------------------

		JsonArray items = dao.exec(db);

		if (items == null) {
			response.sendError(HttpServletResponse.SC_NO_CONTENT);
			return;
		}

		if (items.size() == 0) {
			response.sendError(HttpServletResponse.SC_NO_CONTENT);
			return;
		}

		// -------------------------------------------------------------------------------------

		response.setContentType(CONTENT_TYPE_JSON);
		response.setStatus(HttpServletResponse.SC_OK);

		String res = items.toString();

		PrintWriter out = response.getWriter();
		out.print(res);
		out.flush();

	}

}
