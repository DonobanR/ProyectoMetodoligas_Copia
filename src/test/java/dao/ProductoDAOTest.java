package dao;

import entity.Producto;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.math.BigDecimal;

import static org.junit.Assert.*;

public class ProductoDAOTest {
    private ProductoDAO productoDAO;
    @Before
    public void setUp() throws Exception {
        productoDAO = new ProductoDAO();
    }

    @After
    public void tearDown() throws Exception {
        productoDAO = null;
    }

    @Test
    public void testGuardarProducto() {
        Producto producto = new Producto(null, "iPhone 13 Pro", 1300.00, "Apple", "1 año", 10);
        productoDAO.guardarProducto(producto);
        assertNotNull(producto.getId()); // Verificar que se haya asignado un ID
    }

    @Test
    public void testActualizarProducto() {
        Producto producto = new Producto(null, "Samsung S10+", 750.00, "Samsung", "1 año", 20);
        productoDAO.guardarProducto(producto);

        producto.setNombreProducto("Samsung S10 + Plus");
        producto.setPrecio(new BigDecimal(650.00));
        productoDAO.actualizarProducto(producto);

        Producto productoActualizado = productoDAO.obtenerProductoPorId(producto.getId());
        assertEquals("Samsung S10 + Plus", productoActualizado.getNombreProducto());
        //assertEquals(new BigDecimal(650.00), productoActualizado.getPrecio());
        assertEquals(BigDecimal.valueOf(650.00).setScale(2), productoActualizado.getPrecio().setScale(2));
    }

    @Test
    public void testEliminarProducto() {
        Producto producto = new Producto(null, "Laptop ASUS", 1200.00, "ASUS", "1 año", 10);
        productoDAO.guardarProducto(producto);

        productoDAO.eliminarProducto(producto);
        Producto productoEliminado = productoDAO.obtenerProductoPorId(producto.getId());
        assertNull(productoEliminado);
    }
}