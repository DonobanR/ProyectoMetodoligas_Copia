package servlets;

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del producto a eliminar
        int id = Integer.parseInt(request.getParameter("id"));

        // Crear un objeto Producto con el ID
        Producto producto = new Producto();
        producto.setId(id);

        // Eliminar el producto de la base de datos
        ProductoDAO productoDAO = new ProductoDAO();
        productoDAO.eliminarProducto(producto);
    }
}
