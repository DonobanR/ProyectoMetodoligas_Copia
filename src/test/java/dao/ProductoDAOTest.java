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
        Producto producto = new Producto(null, "iPhone 15 Pro", 1300.00, "Apple", "1 año", 30);
        productoDAO.guardarProducto(producto);
        assertNotNull(producto.getId()); // Verificar que se haya asignado un ID
    }

    @Test
    public void testActualizarProducto() {
        Producto producto = new Producto(null, "Huawei Pura 70", 750.00, "Huawei", "1 año", 20);
        productoDAO.guardarProducto(producto);

        producto.setNombreProducto("HUAWEI Pura 70 Ultra");
        producto.setPrecio(new BigDecimal(850.00));
        productoDAO.actualizarProducto(producto);

        Producto productoActualizado = productoDAO.obtenerProductoPorId(producto.getId());
        assertEquals("HUAWEI Pura 70 Ultra", productoActualizado.getNombreProducto());
        assertEquals(BigDecimal.valueOf(850.00).setScale(2), productoActualizado.getPrecio().setScale(2));
    }

    @Test
    public void testEliminarProducto() {
        Producto producto = new Producto(null, "Laptop ALIENWARE", 1500.00, "DELL", "1 año", 10);
        productoDAO.guardarProducto(producto);

        productoDAO.eliminarProducto(producto);
        Producto productoEliminado = productoDAO.obtenerProductoPorId(producto.getId());
        assertNull(productoEliminado);
    }
}