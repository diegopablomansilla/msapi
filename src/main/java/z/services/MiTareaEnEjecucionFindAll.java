package z.services;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ms.back.EnvironmentVariables;
import com.ms.back.commons.services.AbstractService;
import com.ms.back.model.NoPagin;

import z.dao.MiTareaEnEjecucionFindAllDAO;

public class MiTareaEnEjecucionFindAll extends AbstractService {

	private MiTareaEnEjecucionFindAllDAO dao = new MiTareaEnEjecucionFindAllDAO();

	public MiTareaEnEjecucionFindAll(EnvironmentVariables vars) {
		super(vars);

	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

//		String db = request.getHeader("db");
//
//		if (db == null) {
//			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
//			return;
//		}

		String p = request.getParameter("persona");

		Integer personaId = null;

		if (p == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		p = p.trim();

		if (p.length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		try {
			personaId = Integer.parseInt(p);
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		NoPagin items = dao.exec(vars.getDataBases().get(0), personaId);

		if (items.getCantRows() == 0) {
			response.sendError(HttpServletResponse.SC_NO_CONTENT);
			return;
		}

		response.setContentType(CONTENT_TYPE_JSON);

		String res = items.toJson().toString();

		PrintWriter out = response.getWriter();
		out.print(res);
		out.flush();

		response.setStatus(HttpServletResponse.SC_OK);

	}

}
