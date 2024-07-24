package servlets.cliente;

import dao.ClienteDAO;
import entity.Cliente;
import comprobration.Comprobations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import com.google.gson.Gson;

@WebServlet("/buscarCliente")
public class ObtenerClienteServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();
    private Comprobations comprobations = new Comprobations();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        String filtro = req.getParameter("filtro");
        String terminoBusqueda = req.getParameter("terminoBusqueda");

        try {
            List<Cliente> clientes;
            if (filtro != null && terminoBusqueda != null) {
                clientes = clienteDAO.buscarCliente(filtro, terminoBusqueda);
            } else {
                clientes = clienteDAO.obtenerClientes();
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(clientes));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
