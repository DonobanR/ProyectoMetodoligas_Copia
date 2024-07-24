package servlets.cliente;

import java.io.IOException;
import dao.ClienteDAO;
import entity.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/agregarCliente")
public class AgregarClienteServlet extends HttpServlet {
    private ClienteDAO clienteDAO = new ClienteDAO();
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numeroCedula = request.getParameter("numero_cedula");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String direccion = request.getParameter("direccion");
        String correo = request.getParameter("correo");

        try {
            // Crea un nuevo objeto Cliente
            Cliente cliente = new Cliente();
            cliente.setId(Integer.parseInt(numeroCedula));
            cliente.setNombre(nombre);
            cliente.setApellido(apellido);
            cliente.setDireccion(direccion);
            cliente.setCorreo(correo);

            // Guarda el cliente en la base de datos
            clienteDAO.guardarCliente(cliente);

            // Redirige a la página de gestión de clientes
            response.sendRedirect("gestionCliente.jsp");
        } catch (IllegalArgumentException e) {
            // Maneja el error si ocurre un problema con la entrada del cliente
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("formularioAgregarCliente.jsp").forward(request, response);
        }
    }
}