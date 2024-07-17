package servlets.venta;

import com.google.gson.Gson;
import dao.VentaDAO;
import entity.Venta;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/obtenerVentas")
public class VentaService extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        VentaDAO ventaDAO = new VentaDAO();
        List<Venta> ventas = ventaDAO.obtenerVentas();

        // Pasar la lista de ventas como atributo a la solicitud
        request.setAttribute("ventas", ventas);

        // Redirigir al JSP
        request.getRequestDispatcher("/gestionVentas.jsp").forward(request, response);
    }
}