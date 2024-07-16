package servlets.venta;

import dao.ProductoDAO;
import dao.VentaDAO;
import entity.Cliente;
import entity.DetallesVenta;
import entity.Producto;
import entity.Venta;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/guardarVenta")
public class GuardarVentaServlet extends HttpServlet {

    private final VentaDAO ventaDAO = new VentaDAO();
    private final ProductoDAO productoDAO = new ProductoDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Obtener los datos enviados desde el cliente
        String clienteJson = request.getParameter("cliente");
        String productosJson = request.getParameter("productos");

        // Convertir JSON a objetos
        Cliente cliente = new Gson().fromJson(clienteJson, Cliente.class);
        Producto[] productos = new Gson().fromJson(productosJson, Producto[].class);

        // Crear una nueva venta
        Venta venta = new Venta();
        venta.setCliente(cliente);
        venta.setFecha(new Date());
        BigDecimal total = BigDecimal.ZERO;

        List<DetallesVenta> detallesVentas = new ArrayList<>();

        // Procesar los productos
        for (Producto producto : productos) {
            int cantidad = producto.getStock(); // Usar el campo stock para representar la cantidad vendida
            BigDecimal precio = producto.getPrecio();
            BigDecimal totalProducto = precio.multiply(BigDecimal.valueOf(cantidad));
            total = total.add(totalProducto);

            // Crear detalle de venta
            DetallesVenta detalle = new DetallesVenta();
            detalle.setVenta(venta);
            detalle.setProducto(producto);
            detalle.setCantidad(cantidad);
            detalle.setPrecio(precio);
            detalle.setTotal(totalProducto);
            detallesVentas.add(detalle);

            // Actualizar el stock del producto
            Producto productoActualizado = productoDAO.obtenerProductoPorId(producto.getId());
            productoActualizado.setStock(productoActualizado.getStock() - cantidad);
            productoDAO.actualizarProducto(productoActualizado);
        }

        venta.setTotal(total);
        venta.setDetalles(detallesVentas);

        // Guardar la venta y los detalles en la base de datos
        ventaDAO.guardarVenta(venta);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\": true}");
    }
}