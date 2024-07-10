package dao;

import entity.Cajero;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.util.List;

public class CajeroDAO {
    private void ejecutarTransaccion(OperacionTransaccional operacion) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = null;
            try {
                transaction = session.beginTransaction();
                operacion.ejecutar(session);
                transaction.commit();
            } catch (Exception e) {
                if (transaction != null) {
                    transaction.rollback();
                }
                e.printStackTrace();
            }
        }
    }

    interface OperacionTransaccional {
        void ejecutar(Session session);
    }

    public void guardarCajero(Cajero cajero) {
        ejecutarTransaccion(session -> session.save(cajero));
    }

    public void actualizarCajero(Cajero cajero) {
        ejecutarTransaccion(session -> session.update(cajero));
    }

    public void eliminarCajero(Cajero cajero) {
        ejecutarTransaccion(session -> session.delete(cajero));
    }

    public List<Cajero> obtenerCajeros() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Cajero> query = session.createQuery("FROM Cajero", Cajero.class);
            return query.list();
        }
    }

    public Cajero obtenerCajeroPorNumeroCedula(int numeroCedula) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Cajero.class, numeroCedula);
        }
    }
}