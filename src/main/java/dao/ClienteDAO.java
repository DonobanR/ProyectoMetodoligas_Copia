package dao;

import entity.Cliente;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.util.List;

public class ClienteDAO {
    // Método para guardar un cliente en la base de datos
    public void guardarCliente(Cliente cliente) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();
            session.save(cliente);
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

    // Método para actualizar un cliente en la base de datos
    public void actualizarCliente(Cliente cliente) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();
            session.update(cliente);
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

    // Método para eliminar un cliente de la base de datos
// Método para eliminar un cliente de la base de datos
    public boolean eliminarCliente(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        boolean eliminado = false;

        try {
            transaction = session.beginTransaction();

            // Buscar el cliente por ID
            Cliente cliente = session.get(Cliente.class, id);
            if (cliente != null) {
                // Eliminar el cliente si existe
                session.delete(cliente);
                eliminado = true;
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

        return eliminado;
    }



    // Método para obtener todos los clientes de la base de datos
    public List<Cliente> obtenerClientes() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Cliente> query = session.createQuery("FROM Cliente", Cliente.class);
            return query.list();
        }
    }

    // Método para buscar descuentos en la base de datos
    public List<Cliente> buscarCliente(String filtro, String terminoBusqueda) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // Validación básica para el filtro
            if (!"id".equals(filtro) && !"nombre".equals(filtro) && !"apellido".equals(filtro) && !"correo".equals(filtro)) {
                throw new IllegalArgumentException("Filtro no válido");
            }
            System.out.println("empieza con FROM Cliente WHERE " + filtro + " LIKE :termino");
            String hql = "FROM Cliente WHERE " + filtro + " LIKE :termino";
            Query<Cliente> query = session.createQuery(hql, Cliente.class);
            System.out.println("termino de busqueda: " + terminoBusqueda);
            query.setParameter("termino", "%" + terminoBusqueda + "%");
            return query.list();
        }
    }


    // Método para obtener un cliente por numero_cedula
    public Cliente obtenerClientePorCedula(Integer numeroCedula) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            return session.get(Cliente.class, numeroCedula);
        } finally {
            session.close();
        }
    }

    // Método para verificar si un correo ya existe en la base de datos
    public boolean existeCorreo(String correo) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            String hql = "SELECT COUNT(*) FROM Cliente WHERE correo = :correo";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("correo", correo);
            Long count = query.uniqueResult();
            return count > 0;
        } finally {
            session.close();
        }
    }
}
