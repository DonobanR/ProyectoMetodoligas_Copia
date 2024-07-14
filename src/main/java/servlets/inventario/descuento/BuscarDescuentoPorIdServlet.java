package servlets.inventario.descuento;

import dao.DescuentoDAO;
import entity.Descuento;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;

@WebServlet("/buscarDescuentoPorId")
public class BuscarDescuentoPorIdServlet extends HttpServlet {
    private DescuentoDAO descuentoDAO = new DescuentoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Descuento descuento = descuentoDAO.obtenerDescuentoPorId(id);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        if (descuento != null) {
            String json = new Gson().toJson(descuento);
            out.print(json);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            out.print("{\"error\":\"Descuento no encontrado\"}");
        }
        out.flush();
    }
}