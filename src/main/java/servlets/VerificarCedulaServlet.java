package servlets;

import java.io.IOException;
import comprobration.Comprobations;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

@WebServlet("/verificarCedula")
public class VerificarCedulaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Comprobations comprobations = new Comprobations();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el parámetro de la solicitud
        String numeroCedula = request.getParameter("numero_cedula");
        System.out.println("Número de cédula en servlet: " + numeroCedula);

        // Validar el número de cédula
        boolean esValido = comprobations.verificarCedulaEcuatoriana(numeroCedula);

        // Construir la respuesta JSON
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("valid", esValido);

        // Enviar la respuesta
        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());
    }
}
