package servlets.cliente;

import java.io.IOException;
import dao.ClienteDAO;
import entity.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import comprobration.Comprobations;

@WebServlet("/eliminarCliente")
public class EliminarClienteServlet extends HttpServlet {
    private ClienteDAO clienteDAO = new ClienteDAO();
    private Comprobations comprobations = new Comprobations();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numeroCedula = request.getParameter("numero_cedula");

        try {
            if (!comprobations.verificarCedulaEcuatoriana(numeroCedula)) {
                request.setAttribute("error", "La cédula no es válida");
                request.getRequestDispatcher("formularioEliminarCliente.jsp").forward(request, response);
                return;
            }

            Cliente cliente = clienteDAO.obtenerClientePorCedula(Integer.parseInt(numeroCedula));
            if (cliente != null) {
                clienteDAO.eliminarCliente(cliente);
                response.sendRedirect("formularioEliminarCliente.jsp?id=" + numeroCedula + "&mensaje=eliminacionExitosa");
            } else {
                response.sendRedirect("formularioEliminarCliente.jsp?id=" + numeroCedula + "&mensaje=errorEliminacion");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("formularioEliminarCliente.jsp").forward(request, response);
        }
    }
}
