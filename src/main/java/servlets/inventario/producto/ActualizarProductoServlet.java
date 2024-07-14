package servlets.inventario.producto;

import dao.ProductoDAO;
import entity.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/actualizarProducto")
public class ActualizarProductoServlet extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        double precio = Double.parseDouble(request.getParameter("precio"));
        String marca = request.getParameter("marca");
        String garantia = request.getParameter("garantia");
        int stock = Integer.parseInt(request.getParameter("stock"));
        Producto producto = productoDAO.obtenerProductoPorId(id);
        if (producto != null) {
            producto.setNombreProducto(nombre);
            producto.setPrecio(BigDecimal.valueOf(precio));
            producto.setMarca(marca);
            producto.setGarantia(garantia);
            producto.setStock(stock);
            productoDAO.actualizarProducto(producto);
            // Redirigir con mensaje de éxito
            response.sendRedirect("gestionInventario.jsp?mensaje=actualizacionExitosa");
        } else {
            // Redirigir con mensaje de error
            response.sendRedirect("gestionInventario.jsp?mensaje=errorActualizacion");
        }
    }
}
