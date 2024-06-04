package servlets.incrementosProyecto;

import com.google.gson.Gson;
import dao.ProductoDAO;
import entity.Producto;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/obtenerProductos", "/buscarProducto"})
public class InventarioService extends HttpServlet {
    private final ProductoDAO productoDAO = new ProductoDAO();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String filtro = request.getParameter("filtro");
        String terminoBusqueda = request.getParameter("terminoBusqueda");
        List<Producto> productos;
        if (filtro != null && terminoBusqueda != null && !filtro.isEmpty() && !terminoBusqueda.isEmpty()) {
            productos = productoDAO.buscarProducto(filtro, terminoBusqueda);
        } else {
            productos = productoDAO.obtenerProductos();
        }
        // Convertir la lista de productos a JSON
        String json = new Gson().toJson(productos);
        // Enviar la respuesta como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
