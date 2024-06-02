package servlets;

import dao.ProductoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Producto;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/agregarProducto")
public class AgregarProductoServlet extends HttpServlet {
    private ProductoDAO productoDAO = new ProductoDAO();

    public AgregarProductoServlet(ProductoDAO productoDAO) {
        this.productoDAO = productoDAO;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        double precio = Double.parseDouble(request.getParameter("precio"));
        String marca = request.getParameter("marca");
        String garantia = request.getParameter("garantia");
        int stock = Integer.parseInt(request.getParameter("stock"));

        // Crear un objeto Producto
        Producto producto = new Producto();
        producto.setNombreProducto(nombre);
        producto.setPrecio(BigDecimal.valueOf(precio));
        producto.setMarca(marca);
        producto.setGarantia(garantia);
        producto.setStock(stock);

        // Guardar el producto en la base de datos
        productoDAO.guardarProducto(producto);
    }

    public void setProductoDAO(ProductoDAO productoDAO) {
        this.productoDAO = productoDAO;
    }
}
