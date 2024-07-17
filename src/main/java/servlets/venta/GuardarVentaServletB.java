package servlets.venta;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import dao.ClienteDAO;
import dao.FacturaDAO;
import dao.ProductoDAO;
import dao.VentaDAO;
import entity.Cliente;
import entity.DetallesVenta;
import entity.Factura;
import entity.Producto;
import entity.Venta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

@WebServlet("/guardarVentaB")
public class GuardarVentaServletB extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();
    private final ProductoDAO productoDAO = new ProductoDAO();
    private final VentaDAO ventaDAO = new VentaDAO();
    private final FacturaDAO facturaDAO = new FacturaDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String clienteJson = req.getParameter("cliente");
        String productosJson = req.getParameter("productos");

        if (clienteJson == null || productosJson == null) {
            res.getWriter().write("{\"success\": false}");
            return;
        }

        try {
            // Parsear los datos del cliente
            JSONObject clienteObj = new JSONObject(clienteJson);
            Integer clienteId = clienteObj.getInt("id");
            Cliente cliente = clienteDAO.obtenerClientePorCedula(clienteId);

            // Crear una nueva venta
            Venta venta = new Venta();
            venta.setCliente(cliente);
            venta.setFecha(new Date());

            // Parsear los productos y calcular el total
            JSONArray productosArray = new JSONArray(productosJson);
            BigDecimal total = BigDecimal.ZERO;
            for (int i = 0; i < productosArray.length(); i++) {
                JSONObject productoObj = productosArray.getJSONObject(i);
                Integer productoId = productoObj.getInt("id");
                Producto producto = productoDAO.obtenerProductoPorId(productoId);
                Integer cantidad = productoObj.getInt("stock");
                BigDecimal precio = producto.getPrecio();
                BigDecimal subtotal = precio.multiply(BigDecimal.valueOf(cantidad));

                // Crear un nuevo detalle de venta
                DetallesVenta detalle = new DetallesVenta();
                detalle.setProducto(producto);
                detalle.setCantidad(cantidad);
                detalle.setPrecio(precio);
                detalle.setTotal(subtotal);
                detalle.setVenta(venta);

                // Añadir el detalle a la venta
                venta.getDetalles().add(detalle);
                total = total.add(subtotal);
            }
            venta.setTotal(total);

            // Guardar la venta en la base de datos
            ventaDAO.guardarVenta(venta);

            // Crear una nueva factura
            Factura factura = new Factura();
            factura.setIdVenta(venta);
            factura.setFecha(LocalDate.now());
            factura.setTotal(total);
            facturaDAO.guardarFactura(factura);

            // Generar el PDF
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            Document document = new Document();
            PdfWriter.getInstance(document, baos);
            document.open();

            document.add(new Paragraph("Factura"));
            document.add(new Paragraph("Cliente: " + cliente.getNombre() + " " + cliente.getApellido()));
            document.add(new Paragraph("Fecha: " + new java.sql.Date(System.currentTimeMillis())));
            document.add(new Paragraph("Total: $" + total));

            com.itextpdf.text.pdf.PdfPTable table = new com.itextpdf.text.pdf.PdfPTable(5);
            table.addCell("ID");
            table.addCell("Nombre");
            table.addCell("Precio Unitario");
            table.addCell("Cantidad");
            table.addCell("Total");

            for (DetallesVenta detalle : venta.getDetalles()) {
                table.addCell(detalle.getProducto().getId().toString());
                table.addCell(detalle.getProducto().getNombreProducto());
                table.addCell(detalle.getPrecio().toString());
                table.addCell(detalle.getCantidad().toString());
                table.addCell(detalle.getTotal().toString());
            }

            document.add(table);
            document.close();

            // Enviar el PDF en la respuesta
            res.setContentType("application/pdf");
            res.setHeader("Content-Disposition", "attachment; filename=factura.pdf");
            res.getOutputStream().write(baos.toByteArray());
            res.getOutputStream().flush();

            res.getWriter().write("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().write("{\"success\": false}");
        }
    }
}