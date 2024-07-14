package servlets.inventario.descuento;

import java.io.IOException;
import dao.DescuentoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Descuento;

@WebServlet("/eliminarDescuento")
public class EliminarDescuentoServlet extends HttpServlet {
    private DescuentoDAO descuentoDAO= new DescuentoDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Obtener el ID del descuento a eliminar
        int id = Integer.parseInt(request.getParameter("id"));
        // Obtener el descuento de la base de datos
        Descuento descuento = descuentoDAO.obtenerDescuentoPorId(id);
        if (descuento != null) {
            // Eliminar el descuento de la base de datos
            descuentoDAO.eliminarDescuento(descuento);
            // Redirigir a la página JSP con un mensaje de éxito
            response.sendRedirect("formularioEliminarDescuento.jsp?id=" + id + "&mensaje=eliminacionExitosa");
        } else {
            // Redirigir con mensaje de error
            response.sendRedirect("formularioEliminarDescuento.jsp?id=" + id + "&mensaje=errorEliminacion");
        }
    }
}