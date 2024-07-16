package servlets.venta;

import com.google.gson.Gson;
import dao.ClienteDAO;
import dao.ProductoDAO;
import dao.VentaDAO;
import entity.Cliente;
import entity.Producto;
import entity.Venta;
import entity.DetallesVenta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/generarVenta")
public class VentaServlet extends HttpServlet {
    private final ClienteDAO clienteDAO = new ClienteDAO();
    private final ProductoDAO productoDAO = new ProductoDAO();
    private final VentaDAO ventaDAO = new VentaDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idCliente = request.getParameter("idCliente");
        String[] productosIds = request.getParameterValues("productosIds");
        String[] cantidades = request.getParameterValues("cantidades");

        if (idCliente == null || productosIds == null || cantidades == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Datos de venta incompletos");
            return;
        }

        Cliente cliente = clienteDAO.obtenerClientePorCedula(Integer.parseInt(idCliente));
        BigDecimal totalVenta = BigDecimal.ZERO;

        List<DetallesVenta> detallesVenta = new ArrayList<>();

        for (int i = 0; i < productosIds.length; i++) {
            Producto producto = productoDAO.obtenerProductoPorId(Integer.parseInt(productosIds[i]));
            int cantidad = Integer.parseInt(cantidades[i]);
            BigDecimal precioTotal = producto.getPrecio().multiply(new BigDecimal(cantidad));
            totalVenta = totalVenta.add(precioTotal);

            DetallesVenta detalle = new DetallesVenta();
            detalle.setProducto(producto);
            detalle.setCantidad(cantidad);
            detalle.setPrecio(producto.getPrecio());
            detalle.setTotal(precioTotal);
            detallesVenta.add(detalle);
        }

        Venta venta = new Venta();
        venta.setCliente(cliente);
        venta.setFecha(new Date());
        venta.setTotal(totalVenta);
        venta.setDetalles(detallesVenta);

        ventaDAO.guardarVenta(venta);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(venta));
    }
}