package servlets.incrementosProyecto;

import java.io.IOException;
import java.math.BigDecimal;
import dao.DescuentoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Descuento;

@WebServlet("/agregarDescuento")
public class AgregarDescuentoServlet extends HttpServlet {
    private DescuentoDAO descuentoDAO = new DescuentoDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Obtener los datos del formulario
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        double porcentajeDescuento = Double.parseDouble(request.getParameter("porcentajeDescuento"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        // Crear un objeto Descuento con los datos recibidos
        Descuento descuento = new Descuento();
        descuento.setCodigo(codigo);
        descuento.setNombre(nombre);
        descuento.setPorcentajeDescuento(BigDecimal.valueOf(porcentajeDescuento));
        descuento.setStock(stock);
        // Guardar el descuento en la base de datos
        descuentoDAO.guardarDescuento(descuento);
        // Redirigir a la página de gestión de inventario
        response.sendRedirect("gestionDescuento.jsp");
    }



    public void setDescuentoDAO(DescuentoDAO descuentoDAO) {
        this.descuentoDAO = descuentoDAO;
    }
}
