package servlets.inventario.producto;

import com.google.gson.Gson;
import dao.ProductoDAO;
import entity.Producto;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/buscarProducto")
public class BuscarProductoServlet extends HttpServlet {

    private final ProductoDAO productoDAO = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("idProducto");
        if (id == null || id.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"El ID del producto es requerido.\"}");
            return;
        }

        try {
            int productId = Integer.parseInt(id);
            Producto producto = productoDAO.obtenerProductoPorId(productId);
            if (producto == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Producto no encontrado.\"}");
            } else {
                String json = new Gson().toJson(producto);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"El ID del producto debe ser un número entero.\"}");
        }
    }
}