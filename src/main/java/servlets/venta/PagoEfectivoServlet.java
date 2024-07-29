package servlets.venta;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/efectivo")
public class PagoEfectivoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Servlet llamado: PagoEfectivoServlet");

        // Obtener el montoTotal del parámetro de la solicitud
        String montoTotalParam = request.getParameter("montoTotal");
        System.out.println("Parámetro montoTotal recibido: " + montoTotalParam);

        // Verifica que el parámetro no sea nulo o vacío
        if (montoTotalParam != null && !montoTotalParam.isEmpty()) {
            try {
                BigDecimal montoTotal = new BigDecimal(montoTotalParam);
                request.getSession().setAttribute("montoTotal", montoTotal);
                System.out.println("Monto Total establecido en sesión: " + montoTotal);
            } catch (NumberFormatException e) {
                System.out.println("Error al parsear el montoTotal: " + e.getMessage());
                request.getSession().setAttribute("montoTotal", BigDecimal.ZERO);
            }
        } else {
            request.getSession().setAttribute("montoTotal", BigDecimal.ZERO);
        }

        // Redirige a la página JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("efectivo.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Manejo de la confirmación del pago
        System.out.println("Servlet llamado: PagoEfectivoServlet - Confirmación de Pago");

        // Obtener el montoTotal del parámetro de la solicitud
        String montoTotalParam = request.getParameter("montoTotal");
        System.out.println("Parámetro montoTotal recibido para confirmación: " + montoTotalParam);

        // Aquí puedes agregar la lógica para procesar el pago

        // Redirige a la página JSP después de la confirmación del pago
        response.sendRedirect("venta.jsp?montoTotal=" + montoTotalParam);
    }
}
