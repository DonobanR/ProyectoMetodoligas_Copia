package dao;

import entity.Descuento;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.util.List;

public class DescuentoDAO {
    // Método para guardar un descuento en la base de datos
    public void guardarDescuento(Descuento descuento) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();
            session.save(descuento);
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

    // Método para actualizar un descuento en la base de datos
    public void actualizarDescuento(Descuento descuento) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();
            session.update(descuento);
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

    // Método para eliminar un descuento de la base de datos
    public void eliminarDescuento(Descuento descuento) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();
            session.delete(descuento);
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

    // Método para obtener todos los descuentos de la base de datos
    public List<Descuento> obtenerDescuentos() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Descuento> query = session.createQuery("FROM Descuento", Descuento.class);
            return query.list();
        }
    }

    // Método para buscar descuentos en la base de datos
    public List<Descuento> buscarDescuento(String filtro, String terminoBusqueda) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Descuento WHERE " + filtro + " LIKE :termino";
            Query<Descuento> query = session.createQuery(hql, Descuento.class);
            query.setParameter("termino", "%" + terminoBusqueda + "%");
            return query.list();
        }
    }
}
