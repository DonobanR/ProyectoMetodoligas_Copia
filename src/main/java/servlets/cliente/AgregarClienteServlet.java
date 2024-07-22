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

@WebServlet("/agregarCliente")
public class AgregarClienteServlet extends HttpServlet {
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
            if (!comprobations.verificarCedulaEcuatoriana(numeroCedula)) {
                // Establece el mensaje de error y redirige de nuevo al modal
                request.setAttribute("error", "La cédula no es válida");
                request.getRequestDispatcher("gestionClientes.jsp").forward(request, response);
                return;
            }

            Cliente cliente = new Cliente();
            cliente.setId(Integer.parseInt(numeroCedula));
            cliente.setNombre(nombre);
            cliente.setApellido(apellido);
            cliente.setDireccion(direccion);
            cliente.setCorreo(correo);

            clienteDAO.guardarCliente(cliente);

            // Redirige a la página de gestión de clientes
            response.sendRedirect("gestionClientes.jsp");
        } catch (IllegalArgumentException e) {
            // Establece el mensaje de error y redirige de nuevo al modal
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("gestionClientes.jsp").forward(request, response);
        }
    }
}
