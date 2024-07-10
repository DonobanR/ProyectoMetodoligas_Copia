package servlets;

import com.google.gson.Gson;
import dao.ClienteDAO;
import entity.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/obtenerClientes", "/obtenerClientePorId"})
public class ClienteServlet extends HttpServlet {

    private final ClienteDAO clienteDAO;

    public ClienteServlet() {
        this.clienteDAO = new ClienteDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/obtenerClientes".equals(path)) {
            List<Cliente> clientes = clienteDAO.obtenerClientes();

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(clientes));
        } else if ("/obtenerClientePorId".equals(path)) {
            String idCliente = request.getParameter("id");

            if (idCliente != null && !idCliente.isEmpty()) {
                Cliente cliente = clienteDAO.obtenerClientePorCedula(Integer.parseInt(idCliente));

                if (cliente != null) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(new Gson().toJson(cliente));
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Cliente no encontrado con ID: " + idCliente);
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID del cliente no proporcionado.");
            }
        }
    }
}