package servlets.venta;

import dao.VentaDAO;
import entity.Venta;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/buscarVenta")
public class BuscarVentaService extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idVentaStr = request.getParameter("idVenta");
        if (idVentaStr != null && !idVentaStr.isEmpty()) {
            try {
                int idVenta = Integer.parseInt(idVentaStr);
                VentaDAO ventaDAO = new VentaDAO();
                Venta venta = ventaDAO.obtenerVentaPorId(idVenta);

                // Pasar la venta como atributo a la solicitud
                request.setAttribute("venta", venta);

                // Redirigir al JSP
                request.getRequestDispatcher("/gestionVentas.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID Venta inválido");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID Venta no proporcionado");
        }
    }
}