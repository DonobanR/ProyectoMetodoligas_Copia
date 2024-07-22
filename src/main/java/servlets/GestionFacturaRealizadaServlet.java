package servlet;

import dao.GestionFacturaRealizadaDAO;
import entity.Factura;
import org.hibernate.SessionFactory;
import util.HibernateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/gestionarFacturas")
public class GestionFacturaRealizadaServlet extends HttpServlet {
    private GestionFacturaRealizadaDAO facturaDAO;

    @Override
    public void init() throws ServletException {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        facturaDAO = new GestionFacturaRealizadaDAO(sessionFactory);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String criterio = req.getParameter("criterio");
        String valor = req.getParameter("valor");
        List<Factura> facturas;

        if (criterio != null && valor != null) {
            facturas = facturaDAO.buscarFacturas(criterio, valor);
        } else {
            facturas = facturaDAO.listarTodasLasFacturas();
        }

        req.setAttribute("facturas", facturas);
        req.getRequestDispatcher("/gestionarFacturas.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Implementar lógica para guardar o actualizar facturas si es necesario
    }
}
