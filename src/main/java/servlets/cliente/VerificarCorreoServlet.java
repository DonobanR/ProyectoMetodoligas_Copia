package servlets.cliente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.google.gson.JsonObject;
import dao.ClienteDAO;

@WebServlet("/verificarCorreo")
public class VerificarCorreoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("correo");
        ClienteDAO clienteDAO = new ClienteDAO();
        boolean existe = clienteDAO.existeCorreo(correo);

        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("existe", existe);

        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());
    }
}
