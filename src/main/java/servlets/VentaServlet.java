package servlets;

import entity.Cliente;
import entity.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.io.IOException;

@WebServlet("/fetchData")
public class VentaServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipo = request.getParameter("tipo"); // "cliente" o "producto"
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            if ("cliente".equals(tipo)) {
                String clienteId = request.getParameter("clienteId");
                try {
                    Integer id = Integer.parseInt(clienteId);
                    Cliente cliente = session.get(Cliente.class, id);
                    if (cliente != null) {
                        request.setAttribute("cliente", cliente);
                    } else {
                        request.setAttribute("error", "Cliente no encontrado");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID de cliente inválido");
                }
            } else if ("producto".equals(tipo)) {
                String productoId = request.getParameter("productoId");
                try {
                    Integer id = Integer.parseInt(productoId);
                    Producto producto = session.get(Producto.class, id);
                    if (producto != null) {
                        request.setAttribute("producto", producto);
                    } else {
                        request.setAttribute("error", "Producto no encontrado");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID de producto inválido");
                }
            }
            request.getRequestDispatcher("/gestionVenta.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error en la base de datos");
            request.getRequestDispatcher("/gestionVenta.jsp").forward(request, response);
        }
    }
}