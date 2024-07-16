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

@WebServlet("/obtenerProducto")
public class ObtenerProductoServlet extends HttpServlet {

    private final ProductoDAO productoDAO = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String idProducto = req.getParameter("idProducto");
        res.setContentType("text/html");

        if (idProducto == null || idProducto.isEmpty()) {
            res.getWriter().write("<tr><td colspan='6' style='color: red;'>El parámetro 'idProducto' es obligatorio.</td></tr>");
            return;
        }

        try {
            Integer id = Integer.parseInt(idProducto);
            Producto producto = productoDAO.obtenerProductoPorId(id);

            if (producto == null) {
                res.getWriter().write("<tr><td colspan='6' style='color: red;'>Producto no encontrado.</td></tr>");
                return;
            }

            StringBuilder productoHtml = new StringBuilder();
            productoHtml.append("<tr data-id='").append(producto.getId()).append("'>");
            productoHtml.append("<td class='text-center'>").append(producto.getId()).append("</td>");
            productoHtml.append("<td class='text-center'>").append(producto.getNombreProducto()).append("</td>");
            productoHtml.append("<td class='text-center precio'>").append(producto.getPrecio()).append("</td>");
            productoHtml.append("<td class='text-center cantidad'>0</td>"); // Inicialmente la cantidad será 0
            productoHtml.append("<td class='text-center total'>0.00</td>"); // Inicialmente el total será 0.00
            productoHtml.append("<td class='text-center'><button onclick='eliminarFila(this)'>Eliminar</button></td>");
            productoHtml.append("</tr>");
            res.getWriter().write(productoHtml.toString());
        } catch (NumberFormatException e) {
            res.getWriter().write("<tr><td colspan='6' style='color: red;'>El parámetro 'idProducto' debe ser un número válido.</td></tr>");
        }
    }
}