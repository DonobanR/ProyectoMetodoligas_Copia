package servlets.inventario.descuento;

import java.io.IOException;
import java.math.BigDecimal;
import dao.DescuentoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Descuento;

@WebServlet("/actualizarDescuento")
public class ActualizarDescuentoServlet extends HttpServlet {
    private DescuentoDAO descuentoDAO = new DescuentoDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Obtener los datos del formulario
        int id = Integer.parseInt(request.getParameter("id"));
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        double porcentajeDescuentoStr = Double.parseDouble(request.getParameter("porcentajeDescuento"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        // Crear un objeto Descuento con los datos recibidos
        Descuento descuento = descuentoDAO.obtenerDescuentoPorId(id);
        if (descuento != null) {
            descuento.setCodigo(codigo);
            descuento.setNombre(nombre);
            descuento.setPorcentajeDescuento(BigDecimal.valueOf(porcentajeDescuentoStr));
            descuento.setStock(stock);
            // Actualizar el descuento en la base de datos
            descuentoDAO.actualizarDescuento(descuento);
            // Redirigir a la página JSP con un mensaje de éxito
            response.sendRedirect("gestionDescuento.jsp?id=" + id + "&mensaje=actualizacionExitosa");
        } else {
            // Redirigir con mensaje de error
            response.sendRedirect("gestionDescuento.jsp?mensaje=errorActualizacion");
        }
    }
}