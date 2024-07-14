package servlets.inventario.producto;

import dao.ProductoDAO;
import entity.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/eliminarProducto")
public class EliminarProductoServlet extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Producto producto = productoDAO.obtenerProductoPorId(id);
        if (producto != null) {
            productoDAO.eliminarProducto(producto);

            // Redirigir con mensaje de éxito
            response.sendRedirect("formularioEliminarProducto.jsp?id=" + id + "&mensaje=eliminacionExitosa");
        } else {
            // Redirigir con mensaje de error
            response.sendRedirect("formularioEliminarProducto.jsp?id=" + id + "&mensaje=errorEliminacion");
        }
    }
}