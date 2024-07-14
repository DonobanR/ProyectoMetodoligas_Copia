package servlets.inventario.descuento;

import com.google.gson.Gson;
import dao.DescuentoDAO;
import entity.Descuento;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/obtenerDescuentos", "/buscarDescuento"})
public class DescuentoService extends HttpServlet {

    private final DescuentoDAO descuentoDAO = new DescuentoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String filtro = request.getParameter("filtro");
        String terminoBusqueda = request.getParameter("terminoBusqueda");

        List<Descuento> descuentos;

        if (filtro != null && terminoBusqueda != null && !filtro.isEmpty() && !terminoBusqueda.isEmpty()) {
            descuentos = descuentoDAO.buscarDescuento(filtro, terminoBusqueda);
        } else {
            descuentos = descuentoDAO.obtenerDescuentos();
        }

        // Convertir la lista de descuentos a JSON
        String json = new Gson().toJson(descuentos);

        // Enviar la respuesta como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}