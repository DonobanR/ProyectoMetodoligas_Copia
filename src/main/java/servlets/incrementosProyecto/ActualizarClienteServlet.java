package servlets.incrementosProyecto;

import java.io.IOException;
import dao.ClienteDAO;
import entity.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/actualizarCliente")
public class ActualizarClienteServlet extends HttpServlet {
    private ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        int numeroCedula = Integer.parseInt(request.getParameter("numero_cedula"));
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String direccion = request.getParameter("direccion");
        String correo = request.getParameter("correo");

        // Obtener el cliente existente
        Cliente cliente = clienteDAO.obtenerClientePorCedula(numeroCedula);
        if (cliente != null) {
            // Actualizar los datos del cliente
            cliente.setNombre(nombre);
            cliente.setApellido(apellido);
            cliente.setDireccion(direccion);
            cliente.setCorreo(correo);

            // Actualizar el cliente en la base de datos
            clienteDAO.actualizarCliente(cliente);

            // Redirigir a la página de gestión de clientes con un mensaje de éxito
            response.sendRedirect("gestionCliente.jsp?id=" + numeroCedula +"&mensaje=actualizacionExitosa");
        } else {
            // Redirigir con mensaje de error
            response.sendRedirect("gestionCliente.jsp?mensaje=errorActualizacion");
        }
    }
}
