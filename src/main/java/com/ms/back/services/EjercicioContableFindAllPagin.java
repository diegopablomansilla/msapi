package com.ms.back.services;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ms.back.EnvironmentVariables;
import com.ms.back.commons.services.AbstractService;
import com.ms.back.dao.EjercicioContableFindAllPaginDAO;
import com.ms.back.model.Pagin;

public class EjercicioContableFindAllPagin extends AbstractService {

	private EjercicioContableFindAllPaginDAO dao = new EjercicioContableFindAllPaginDAO();

	public EjercicioContableFindAllPagin(EnvironmentVariables vars) {
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
		}

		// -------------------------------------------------------------------------------------

		Pagin items = dao.exec(db, pageRequest, lastIndexOld);

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
