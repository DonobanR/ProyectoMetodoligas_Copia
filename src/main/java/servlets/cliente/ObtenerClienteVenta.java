package servlets.cliente;

import dao.ClienteDAO;
import entity.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/obtenerCliente")
public class ObtenerClienteVenta extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        String numeroCedula = req.getParameter("numeroCedula");
        response.setContentType("text/html");

        if (numeroCedula == null || numeroCedula.isEmpty()) {
            response.getWriter().write("<p style='color: red;'>El parámetro 'numeroCedula' es obligatorio.</p>");
            return;
        }

        try {
            Integer cedula = Integer.parseInt(numeroCedula);
            Cliente cliente = clienteDAO.obtenerClientePorCedula(cedula);

            if (cliente == null) {
                response.getWriter().write("<p style='color: red;'>Cliente no encontrado.</p>");
                return;
            }

            StringBuilder clienteHtml = new StringBuilder();
            clienteHtml.append("<h2>Datos del Cliente</h2>");
            clienteHtml.append("<p><strong>Cédula:</strong> ").append(cliente.getId()).append("</p>");
            clienteHtml.append("<p><strong>Nombre:</strong> ").append(cliente.getNombre()).append("</p>");
            clienteHtml.append("<p><strong>Apellido:</strong> ").append(cliente.getApellido()).append("</p>");
            clienteHtml.append("<p><strong>Dirección:</strong> ").append(cliente.getDireccion()).append("</p>");
            clienteHtml.append("<p><strong>Correo:</strong> ").append(cliente.getCorreo()).append("</p>");
            response.getWriter().write(clienteHtml.toString());
        } catch (NumberFormatException e) {
            response.getWriter().write("<p style='color: red;'>El parámetro 'numeroCedula' debe ser un número válido.</p>");
        }
    }
}