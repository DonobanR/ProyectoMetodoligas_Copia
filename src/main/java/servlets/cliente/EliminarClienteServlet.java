package servlets.cliente;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.JsonObject;
import dao.ClienteDAO;
import entity.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/eliminarCliente")
public class EliminarClienteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String id = request.getParameter("id");

        boolean success = false;
        if (id != null && !id.isEmpty()) {
            ClienteDAO clienteDAO = new ClienteDAO();
            try {
                success = clienteDAO.eliminarCliente(Integer.parseInt(id));
            } catch (NumberFormatException e) {
                success = false;
            }
        }

        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", success);
        out.print(jsonResponse.toString());
        out.flush();
    }
}
