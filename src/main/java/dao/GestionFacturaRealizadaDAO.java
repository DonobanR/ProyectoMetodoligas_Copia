package dao;

import entity.Factura;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class GestionFacturaRealizadaDAO {

    private SessionFactory sessionFactory;

    public GestionFacturaRealizadaDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public List<Factura> listarTodasLasFacturas() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM Factura", Factura.class).list();
        }
    }

    public List<Factura> buscarFacturas(String criterio, String valor) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM Factura WHERE " + criterio + " LIKE :valor";
            Query<Factura> query = session.createQuery(hql, Factura.class);
            query.setParameter("valor", "%" + valor + "%");
            return query.list();
        }
    }

    public void guardarOActualizarFactura(Factura factura) {
        Transaction transaction = null;
        try (Session session = sessionFactory.openSession()) {
            transaction = session.beginTransaction();
            session.saveOrUpdate(factura);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw e;
        }
    }

}
