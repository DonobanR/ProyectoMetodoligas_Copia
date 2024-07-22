package servlets.comprobacionCedula;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class verificarCedulaServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cedula = request.getParameter("cedula");
        boolean esValida = validarCedula(cedula);

        if (!esValida) {
            request.setAttribute("errorMensaje", "La cédula no es válida.");
            request.getRequestDispatcher("formularioAgregarCliente.jsp").forward(request, response);
        } else {

        }
    }

    private boolean validarCedula(String cedula) {
        boolean cedulaCorrecta = false;

        try {
            if (cedula.length() == 10) {
                int tercerDigito = Integer.parseInt(cedula.substring(2, 3));
                if (tercerDigito < 6) {
                    int[] coefValCedula = { 2, 1, 2, 1, 2, 1, 2, 1, 2 };
                    int verificador = Integer.parseInt(cedula.substring(9, 10));
                    int suma = 0;
                    int digito = 0;
                    for (int i = 0; i < (cedula.length() - 1); i++) {
                        digito = Integer.parseInt(cedula.substring(i, i + 1)) * coefValCedula[i];
                        suma += ((digito % 10) + (digito / 10));
                    }

                    if ((suma % 10 == 0 && suma % 10 == verificador) ||
                            (10 - (suma % 10) == verificador)) {
                        cedulaCorrecta = true;
                    }
                }
            }
        } catch (NumberFormatException nfe) {
            cedulaCorrecta = false;
        }

        if (!cedulaCorrecta) {
            throw new IllegalArgumentException("La Cédula ingresada es Incorrecta");
        }
        return cedulaCorrecta;
    }
}
