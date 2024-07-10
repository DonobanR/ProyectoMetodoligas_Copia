package servlets.Sprint1;

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        int numeroCedula = Integer.parseInt(request.getParameter("numero_cedula"));
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String direccion = request.getParameter("direccion");
        String correo = request.getParameter("correo");

        // Crear un objeto Cliente con los datos recibidos
        Cliente cliente = new Cliente();
        cliente.setNumeroCedula(numeroCedula);
        cliente.setNombre(nombre);
        cliente.setApellido(apellido);
        cliente.setDireccion(direccion);
        cliente.setCorreo(correo);

        // Guardar el cliente en la base de datos
        clienteDAO.guardarCliente(cliente);

        // Redirigir a la página de gestión de clientes
        response.sendRedirect("gestionCliente.jsp");
    }
}
