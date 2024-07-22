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

@WebServlet("/actualizarCliente")
public class ActualizarClienteServlet extends HttpServlet {
    private ClienteDAO clienteDAO = new ClienteDAO();
    private Comprobations comprobations = new Comprobations();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numeroCedula = request.getParameter("numero_cedula");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String direccion = request.getParameter("direccion");
        String correo = request.getParameter("correo");

        try {
            // Verificar si la cédula es válida
            if (!comprobations.verificarCedulaEcuatoriana(numeroCedula)) {
                request.setAttribute("error", "La cédula no es válida");
                request.getRequestDispatcher("formularioActualizarCliente.jsp").forward(request, response);
                return;
            }

            // Obtener el cliente por cédula
            Cliente cliente = clienteDAO.obtenerClientePorCedula(Integer.parseInt(numeroCedula));

            // Verificar si el cliente existe
            if (cliente == null) {
                request.setAttribute("error", "El cliente con esa cédula no existe");
                request.getRequestDispatcher("gestionCliente.jsp").forward(request, response);
                return;
            }

            // Actualizar los datos del cliente
            cliente.setNombre(nombre);
            cliente.setApellido(apellido);
            cliente.setDireccion(direccion);
            cliente.setCorreo(correo);

            clienteDAO.actualizarCliente(cliente);

            response.sendRedirect("gestionCliente.jsp?id=" + numeroCedula + "&mensaje=actualizacionExitosa");
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("gestionCliente.jsp").forward(request, response);
        }
    }
}
