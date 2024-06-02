package incrementos2;

import dao.ProductoDAO;
import entity.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.annotation.WebServlet;
import util.HibernateUtil;


//@WebServlet("/agregarProducto")
public class AgregarProductoInventario extends HttpServlet {

    private ProductoDAO productoDAO = new ProductoDAO();

    public AgregarProductoInventario(ProductoDAO productoDAO) {
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

}
