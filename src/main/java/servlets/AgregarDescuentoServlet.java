package servlets;

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

    private DescuentoDAO descuentoDAO;

    public AgregarDescuentoServlet(DescuentoDAO descuentoDAO) {
        this.descuentoDAO = descuentoDAO;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Obtener los datos del formulario
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        String porcentajeDescuentoStr = request.getParameter("porcentajeDescuento");
        String stockStr = request.getParameter("stock");

        // Verificar si los campos obligatorios están vacíos
        if (codigo == null || codigo.isEmpty() || nombre == null || nombre.isEmpty() ||
                porcentajeDescuentoStr == null || porcentajeDescuentoStr.isEmpty() ||
                stockStr == null || stockStr.isEmpty()) {

            request.setAttribute("mensaje", "Todos los campos obligatorios deben ser completados.");
            request.getRequestDispatcher("agregarDescuento.jsp").forward(request, response);
            return;
        }

        // Convertir los valores de porcentajeDescuento y stock
        BigDecimal porcentajeDescuento = new BigDecimal(porcentajeDescuentoStr);
        Integer stock = Integer.parseInt(stockStr);

        // Crear un objeto Descuento con los datos recibidos
        Descuento descuento = new Descuento();
        descuento.setCodigo(codigo);
        descuento.setNombre(nombre);
        descuento.setPorcentajeDescuento(porcentajeDescuento);
        descuento.setStock(stock);

        // Guardar el descuento en la base de datos
        DescuentoDAO descuentoDAO = new DescuentoDAO();
        descuentoDAO.guardarDescuento(descuento);

        // Establecer un mensaje de éxito y reenviar a la página JSP
        request.setAttribute("mensaje", "Descuento agregado exitosamente.");
        request.setAttribute("agregarOtro", true);
        request.getRequestDispatcher("gestionInventario.jsp").forward(request, response);
    }
}