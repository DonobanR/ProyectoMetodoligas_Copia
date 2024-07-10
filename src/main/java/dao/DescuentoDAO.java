descuentoDAO:

package dao;

import entity.Descuento;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.util.List;

public class DescuentoDAO {
    // Método privado para ejecutar una operación transaccional
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

    // Interfaz funcional para operaciones transaccionales
    interface OperacionTransaccional {
        void ejecutar(Session session);
    }

    // Método para guardar un descuento en la base de datos
    public void guardarDescuento(Descuento descuento) {
        ejecutarTransaccion(session -> session.save(descuento));
    }

    // Método para actualizar un descuento en la base de datos
    public void actualizarDescuento(Descuento descuento) {
        ejecutarTransaccion(session -> session.update(descuento));
    }

    // Método para eliminar un descuento de la base de datos
    public void eliminarDescuento(Descuento descuento) {
        ejecutarTransaccion(session -> session.delete(descuento));
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

    // Método para obtener un descuento por su ID
    public Descuento obtenerDescuentoPorId(Integer id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Descuento.class, id);
        }
    }
}
