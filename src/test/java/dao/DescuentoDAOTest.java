package dao;

import entity.Descuento;
import entity.Producto;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.Assert.*;

public class DescuentoDAOTest {
    private DescuentoDAO descuentoDAO;
    @Before
    public void setUp() throws Exception {
        descuentoDAO = new DescuentoDAO();
    }

    @After
    public void tearDown() throws Exception {
        descuentoDAO = null;
    }

    @Test
    public void testGuardarDescuento() {
        Descuento descuento = new Descuento();
        descuento.setCodigo("78457845");
        descuento.setNombre("BigDescuentoECU");
        descuento.setPorcentajeDescuento(BigDecimal.TEN);
        descuento.setStock(100);

        descuentoDAO.guardarDescuento(descuento);
        assertNotNull(descuento.getId()); // Verificar que se haya asignado un ID
    }

    @Test
    public void testActualizarDescuento() {
        Descuento descuento = new Descuento();
        descuento.setCodigo("121212");
        descuento.setNombre("DescuentoBig2025");
        descuento.setPorcentajeDescuento(BigDecimal.TEN);
        descuento.setStock(100);

        descuentoDAO.guardarDescuento(descuento);

        descuento.setNombre("DescuentoBig2025");
        descuento.setPorcentajeDescuento(BigDecimal.valueOf(40));

        descuentoDAO.actualizarDescuento(descuento);

        Descuento descuentoActualizado = descuentoDAO.obtenerDescuentoPorId(descuento.getId());

        assertEquals("DescuentoBig2025", descuentoActualizado.getNombre());
        assertEquals(BigDecimal.valueOf(40.00).setScale(2), descuentoActualizado.getPorcentajeDescuento().setScale(2));

    }

    @Test
    public void testEliminarDescuento() {
        Descuento descuento = new Descuento();
        descuento.setCodigo("4565452");
        descuento.setNombre("Descuento2020");
        descuento.setPorcentajeDescuento(BigDecimal.TEN);
        descuento.setStock(50);
        descuentoDAO.guardarDescuento(descuento);
        descuentoDAO.eliminarDescuento(descuento);

        Descuento descuentoEliminado = descuentoDAO.obtenerDescuentoPorId(descuento.getId());
        assertNull(descuentoEliminado);
    }

    @Test
    public void testObtenerDescuento() {
        List<Descuento> descuentos = descuentoDAO.obtenerDescuentos();
        assertNotNull(descuentos);
    }
}