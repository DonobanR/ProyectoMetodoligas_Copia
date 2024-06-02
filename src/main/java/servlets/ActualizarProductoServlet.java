package servlets;

import dao.ProductoDAO;
import entity.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/actualizarProducto")
public class ActualizarProductoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        double precio = Double.parseDouble(request.getParameter("precio"));
        String marca = request.getParameter("marca");
        String garantia = request.getParameter("garantia");
        int stock = Integer.parseInt(request.getParameter("stock"));

        // Crear un objeto Producto
        Producto producto = new Producto(id, nombre, precio, marca, garantia, stock);

        // Actualizar el producto en la base de datos
        ProductoDAO productoDAO = new ProductoDAO();
        productoDAO.actualizarProducto(producto);

    }
}
