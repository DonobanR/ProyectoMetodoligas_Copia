package servlets.cliente;

import com.google.gson.Gson;
import dao.ClienteDAO;
import entity.Cliente;
import comprobration.Comprobations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/obtenerClientePorCedula")
public class ObtenerClientePorCedulaServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();
    private Comprobations comprobations = new Comprobations();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        String numeroCedula = req.getParameter("id");

        try {
            if (numeroCedula != null && comprobations.verificarCedulaEcuatoriana(numeroCedula)) {
                Cliente cliente = clienteDAO.obtenerClientePorCedula(Integer.parseInt(numeroCedula));
                String json = new Gson().toJson(cliente);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            }
        } catch (IllegalArgumentException e) {
            response.setContentType("text/html");
            response.getWriter().write("<p style='color: red;'>" + e.getMessage() + "</p>");
        }
    }
}
