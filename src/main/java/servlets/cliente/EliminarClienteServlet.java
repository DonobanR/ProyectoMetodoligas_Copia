package servlets.cliente;

import java.io.IOException;
import dao.ClienteDAO;
import entity.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/eliminarCliente")
public class EliminarClienteServlet extends HttpServlet {
    private ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del cliente a eliminar
        int numeroCedula = Integer.parseInt(request.getParameter("numero_cedula"));

        // Obtener el cliente de la base de datos
        Cliente cliente = clienteDAO.obtenerClientePorCedula(numeroCedula);
        if (cliente != null) {
            // Eliminar el cliente de la base de datos
            clienteDAO.eliminarCliente(cliente);

            // Redirigir a la página de gestión de clientes con un mensaje de éxito
            response.sendRedirect("formularioEliminarCliente.jsp?id=" + numeroCedula + "&mensaje=eliminacionExitosa");
        } else {
            // Redirigir con mensaje de error
            response.sendRedirect("formularioEliminarCliente.jsp?id=" + numeroCedula + "&mensaje=errorEliminacion");
        }


    }
}
