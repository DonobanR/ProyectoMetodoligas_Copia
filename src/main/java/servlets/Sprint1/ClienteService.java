package servlets.Sprint1;

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

@WebServlet({"/obtenerClientes", "/buscarClientes"})
public class ClienteService extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        String filtro = req.getParameter("filtro");
        String terminoBusqueda = req.getParameter("terminoBusqueda");

        List<Cliente> clientes;

        if (filtro != null && terminoBusqueda != null && !filtro.isEmpty() && !terminoBusqueda.isEmpty()) {
            clientes = clienteDAO.buscarCliente(filtro, terminoBusqueda);
        } else {
            clientes = clienteDAO.obtenerClientes();
        }

        String json = new Gson().toJson(clientes);

        // Enviar la respuesta como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
