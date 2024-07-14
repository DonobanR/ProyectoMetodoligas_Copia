package servlets.venta;

import com.google.gson.Gson;
import dao.ClienteDAO;
import dao.ProductoDAO;
import dao.DescuentoDAO;
import entity.Cliente;
import entity.Producto;
import entity.Descuento;
import entity.Venta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/generarVenta")
public class VentaServlet extends HttpServlet {
    private final ClienteDAO clienteDAO = new ClienteDAO();
    private final ProductoDAO productoDAO = new ProductoDAO();
    private final DescuentoDAO descuentoDAO = new DescuentoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            obtenerClientes(request, response);
        } else if ("obtenerProductos".equals(action)) {
            obtenerProductos(request, response);
        } else if ("obtenerDescuentos".equals(action)) {
            obtenerDescuentos(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no reconocida");
        }
    }

    private void obtenerClientes(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Cliente> clientes = clienteDAO.obtenerClientes();
        String json = new Gson().toJson(clientes);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    private void obtenerProductos(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Producto> productos = productoDAO.obtenerProductos();
        String json = new Gson().toJson(productos);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    private void obtenerDescuentos(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Descuento> descuentos = descuentoDAO.obtenerDescuentos();
        String json = new Gson().toJson(descuentos);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idCliente = request.getParameter("idCliente");
        String idDescuento = request.getParameter("idDescuento");
        String[] productosIds = request.getParameterValues("productosIds");
        String[] cantidades = request.getParameterValues("cantidades");

        if (idCliente == null || productosIds == null || cantidades == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Datos de venta incompletos");
            return;
        }

        Cliente cliente = clienteDAO.obtenerClientePorCedula(Integer.parseInt(idCliente));
        Descuento descuento = descuentoDAO.obtenerDescuentoPorId(Integer.parseInt(idDescuento));
        BigDecimal totalVenta = BigDecimal.ZERO;

        for (int i = 0; i < productosIds.length; i++) {
            Producto producto = productoDAO.obtenerProductoPorId(Integer.parseInt(productosIds[i]));
            int cantidad = Integer.parseInt(cantidades[i]);
            totalVenta = totalVenta.add(producto.getPrecio().multiply(new BigDecimal(cantidad)));
        }

        Venta venta = new Venta();
        venta.setCliente(cliente);
        venta.setDescuento(descuento);
        venta.setNumeroProductos(productosIds.length);
        venta.setTotalVenta(totalVenta);

        // Aquí puedes agregar el código para guardar la venta en la base de datos
        // ventaDAO.guardarVenta(venta);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(venta));
    }
}
