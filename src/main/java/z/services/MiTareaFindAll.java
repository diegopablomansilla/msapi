package z.services;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ms.back.EnvironmentVariables;
import com.ms.back.commons.services.AbstractService;
import com.ms.back.model.NoPagin;

import z.dao.MiTareaFindAllDAO;

public class MiTareaFindAll extends AbstractService {

	private MiTareaFindAllDAO dao = new MiTareaFindAllDAO();

	public MiTareaFindAll(EnvironmentVariables vars) {
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

		String s = request.getParameter("seccion");
		String p = request.getParameter("puesto");

		Integer seccionId = null;
		Integer puestoId = null;

		if (s == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		s = s.trim();

		if (s.length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		try {			
			seccionId = Integer.parseInt(s);
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		if (p != null && p.trim().length() > 0) {
			try {
				p = p.trim();
				puestoId = Integer.parseInt(p);
			} catch (NumberFormatException e) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST);
				return;
			}
		}

		NoPagin items = dao.exec(vars.getDataBases().get(0), seccionId, puestoId);

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
