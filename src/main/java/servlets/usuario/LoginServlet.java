package servlets.usuario;

import dao.UsuarioDAO;

import entity.Usuario;
import hash.PasswordHasher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // Hash de la contraseña
        String contrasenaHash = PasswordHasher.hashPassword(contrasena);

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuarioObj = usuarioDAO.findByUsername(usuario);

        if (usuarioObj != null && usuarioObj.getContrasena().equals(contrasenaHash)) {

            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuarioObj);
            session.setAttribute("tipoUsuario", usuarioObj.getTipoUsuario());  // Almacenar el tipo de usuario
            // Credenciales válidas, redirigir a la página principal o a la que corresponda
            response.sendRedirect("inicio.jsp");
        } else {
            // Credenciales no válidas, redirigir a la página de inicio de sesión con mensaje de error
            response.sendRedirect("iniciarSesion.jsp?error=true");
        }
    }
}
