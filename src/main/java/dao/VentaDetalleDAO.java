package dao;

import entity.DetallesVenta;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class VentaDetalleDAO {
    public void guardarVentaDetalle(DetallesVenta detalle) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();
            session.save(detalle);
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
