package com.ms.back.services;

import java.io.PrintWriter;

import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ms.back.EnvironmentVariables;
import com.ms.back.commons.services.AbstractService;
import com.ms.back.dao.CentroCostoContableFindOneByTextDAO;

public class CentroCostoContableFindOneByText extends AbstractService {

	private CentroCostoContableFindOneByTextDAO dao = new CentroCostoContableFindOneByTextDAO();

	public CentroCostoContableFindOneByText(EnvironmentVariables vars) {
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

		String text = request.getParameter("text");
		if (text == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		text = text.trim();
		if (text.length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		// -------------------------------------------------------------------------------------

		String ejercicioContableId = request.getParameter("ejercicio");
		if (ejercicioContableId == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		ejercicioContableId = ejercicioContableId.trim();
		if (ejercicioContableId.length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		// -------------------------------------------------------------------------------------

		JsonObject item = dao.exec(db, text, ejercicioContableId);

		if (item == null) {
			response.sendError(HttpServletResponse.SC_NO_CONTENT);
			return;
		}

		// -------------------------------------------------------------------------------------

		response.setContentType(CONTENT_TYPE_JSON);
		response.setStatus(HttpServletResponse.SC_OK);

		String res = item.toString();

		PrintWriter out = response.getWriter();
		out.print(res);
		out.flush();

	}

}
