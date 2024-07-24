package servlets.usuario;

import dao.UsuarioDAO;
import entity.Administradoresinventario;
import entity.Cajero;
import entity.Usuario;
import hash.PasswordHasher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import comprobration.Comprobations;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {
    private Comprobations comprobations = new Comprobations();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recoger parámetros del formulario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String numeroCedulaStr = request.getParameter("numeroCedula");
        String direccion = request.getParameter("direccion");
        String correo = request.getParameter("correo");
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");
        String tipoUsuario = request.getParameter("tipoUsuario");

        // Validar número de cédula
        boolean esValidoCedula = comprobations.verificarCedulaEcuatoriana(numeroCedulaStr);
        if (!esValidoCedula) {
            response.sendRedirect("registarUsuario.jsp?error=Número de cédula inválido");
            return;
        }

        // Convertir número de cédula a entero
        int numeroCedula = Integer.parseInt(numeroCedulaStr);

        // Hash de la contraseña
        String contrasenaHash = PasswordHasher.hashPassword(contrasena);

        // Crear instancia del usuario
        Usuario nuevoUsuario;
        if (tipoUsuario.equals("Cajero")) {
            nuevoUsuario = new Cajero();
        } else if (tipoUsuario.equals("Administrador")) {
            nuevoUsuario = new Administradoresinventario();
        } else {
            // Manejar error
            response.sendRedirect("registarUsuario.jsp?error=Tipo de usuario no válido");
            return;
        }

        // Configurar los valores del nuevo usuario
        nuevoUsuario.setNombre(nombre);
        nuevoUsuario.setApellido(apellido);
        nuevoUsuario.setNumeroCedula(numeroCedulaStr);
        nuevoUsuario.setDireccion(direccion);
        nuevoUsuario.setCorreo(correo);
        nuevoUsuario.setUsuario(usuario);
        nuevoUsuario.setContrasena(contrasenaHash);
        nuevoUsuario.setTipoUsuario(tipoUsuario);

        // Guardar el usuario en la base de datos
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        usuarioDAO.save(nuevoUsuario);

        // Redirigir a la página de registro con el parámetro de éxito
        response.sendRedirect("registarUsuario.jsp?success=true");
    }
}
