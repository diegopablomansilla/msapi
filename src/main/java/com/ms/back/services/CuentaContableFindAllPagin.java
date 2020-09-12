package com.ms.back.services;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ms.back.EnvironmentVariables;
import com.ms.back.commons.services.AbstractService;
import com.ms.back.dao.CuentaContableFindAllPaginDAO;
import com.ms.back.model.Pagin;

public class CuentaContableFindAllPagin extends AbstractService {

	private CuentaContableFindAllPaginDAO dao = new CuentaContableFindAllPaginDAO();

	public CuentaContableFindAllPagin(EnvironmentVariables vars) {
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

		String pageRequest = request.getParameter("pr");
		if (pageRequest == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		pageRequest = pageRequest.trim();
		if (pageRequest.length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		if (pageRequest.equals("FIRST") == false && pageRequest.equals("LAST") == false
				&& pageRequest.equals("NEXT") == false && pageRequest.equals("BACK") == false) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		// -------------------------------------------------------------------------------------

		Integer lastIndexOld = null;
		String lastIndexOldString = request.getParameter("i");
		if (lastIndexOldString == null) {
			lastIndexOldString = "0";
		}
		lastIndexOldString = lastIndexOldString.trim();
		if (lastIndexOldString.length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		try {
			lastIndexOld = Integer.parseInt(lastIndexOldString);
		} catch (NumberFormatException e) {
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

		String por = request.getParameter("por");
		if (por == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		por = por.trim();
		if (por.length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		if (por.equals("CUENTA_CONTABLE") == false && por.equals("NOMBRE") == false
				&& por.equals("CUENTA_AGRUPADORA") == false && por.equals("CENTRO_DE_COSTO") == false
				&& por.equals("PUNTO_DE_EQUILIBRIO") == false) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		// -------------------------------------------------------------------------------------

		String op = request.getParameter("op");
		if (op == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		op = op.trim();
		if (op.length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		if (op.equals("SW_ICT_O") == false && op.equals("C_ICT_A") == false) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		// -------------------------------------------------------------------------------------

		String filtro = request.getParameter("filtro");

		if (op != null) {
			op = op.trim();
		}

		// -------------------------------------------------------------------------------------

		Pagin items = dao.exec(db, pageRequest, lastIndexOld, ejercicioContableId, por, filtro, op);

		if (items.getCantRows() == 0) {
			response.sendError(HttpServletResponse.SC_NO_CONTENT);
			return;
		}

		// -------------------------------------------------------------------------------------

		response.setContentType(CONTENT_TYPE_JSON);
		response.setStatus(HttpServletResponse.SC_OK);

		String res = items.toJson().toString();

		PrintWriter out = response.getWriter();
		out.print(res);
		out.flush();

	}

}
