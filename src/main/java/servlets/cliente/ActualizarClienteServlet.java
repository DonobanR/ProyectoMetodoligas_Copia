package servlets.cliente;

import dao.ClienteDAO;
import entity.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/actualizarCliente")
public class ActualizarClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numeroCedulaStr = request.getParameter("numero_cedula");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String direccion = request.getParameter("direccion");
        String correo = request.getParameter("correo");

        if (numeroCedulaStr != null && !numeroCedulaStr.trim().isEmpty()) {
            try {
                int numeroCedula = Integer.parseInt(numeroCedulaStr);
                ClienteDAO clienteDAO = new ClienteDAO();
                Cliente cliente = clienteDAO.obtenerClientePorCedula(numeroCedula);

                if (cliente != null) {
                    cliente.setNombre(nombre);
                    cliente.setApellido(apellido);
                    cliente.setDireccion(direccion);
                    cliente.setCorreo(correo);

                    clienteDAO.actualizarCliente(cliente);
                    response.sendRedirect("gestiónCliente.jsp");
                } else {
                    request.setAttribute("errorMessage", "Cliente no encontrado.");
                    request.getRequestDispatcher("formularioActualizarCliente.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Número de cédula inválido.");
                request.getRequestDispatcher("formularioActualizarCliente.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Error al actualizar cliente: " + e.getMessage());
                request.getRequestDispatcher("formularioActualizarCliente.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Número de cédula no proporcionado.");
            request.getRequestDispatcher("formularioActualizarCliente.jsp").forward(request, response);
        }
    }
}
