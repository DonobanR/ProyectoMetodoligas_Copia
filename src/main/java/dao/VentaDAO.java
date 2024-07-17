package dao;

import entity.DetallesVenta;
import entity.Venta;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.util.List;

public class VentaDAO {
    public void guardarVenta(Venta venta) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();
            session.save(venta);
            for (DetallesVenta detalle : venta.getDetalles()) {
                detalle.setVenta(venta);
                session.save(detalle);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    public List<Venta> obtenerVentas() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        List<Venta> ventas = null;

        try {
            transaction = session.beginTransaction();
            Query<Venta> query = session.createQuery("from Venta", Venta.class);
            ventas = query.list();

            // Inicializar las colecciones perezosas
            for (Venta venta : ventas) {
                Hibernate.initialize(venta.getDetalles());
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }

        return ventas;
    }
}
