package servlets.inventario.descuento;

import dao.ProductoDAO;
import entity.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;

@WebServlet("/buscarProductoPorId")
public class BuscarProductoPorIdServlet extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Producto producto = productoDAO.obtenerProductoPorId(id);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        if (producto != null) {
            String json = new Gson().toJson(producto);
            out.print(json);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            out.print("{\"error\":\"Producto no encontrado\"}");
        }
        out.flush();
    }
}

