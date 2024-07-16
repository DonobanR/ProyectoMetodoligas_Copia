package dao;

import entity.DetallesVenta;
import entity.Venta;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

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
}
