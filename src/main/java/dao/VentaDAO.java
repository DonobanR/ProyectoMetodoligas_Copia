package dao;

import entity.Venta;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class VentaDAO {

    public void guardarVenta(Venta venta) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            session.save(venta);
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}