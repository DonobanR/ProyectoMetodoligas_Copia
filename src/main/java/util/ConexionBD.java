package util;

import org.hibernate.Session;
import org.hibernate.Transaction;

public class ConexionBD {
    public static Session getSession() {
        return HibernateUtil.getSessionFactory().openSession();
    }

    public static void closeSession(Session session) {
        if (session != null) {
            session.close();
        }
    }

    public static void beginTransaction() {
        getSession().beginTransaction();
    }

    public static void commitTransaction() {
        getSession().getTransaction().commit();
    }

    public static void rollbackTransaction() {
        getSession().getTransaction().rollback();
    }
}

