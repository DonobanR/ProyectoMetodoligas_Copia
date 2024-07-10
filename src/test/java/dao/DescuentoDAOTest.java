test:

package dao;

import entity.Descuento;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

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
        // Generar un código único
        String uniqueCode = UUID.randomUUID().toString();
        descuento.setCodigo(uniqueCode);
        descuento.setNombre("BigDescuentoPEU");
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

        descuento.setNombre("DescuentoActualizado");
        descuento.setPorcentajeDescuento(BigDecimal.valueOf(40));

        descuentoDAO.actualizarDescuento(descuento);

        Descuento descuentoActualizado = descuentoDAO.obtenerDescuentoPorId(descuento.getId());

        assertEquals("DescuentoActualizado", descuentoActualizado.getNombre());
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
    public void testObtenerDescuentos() {
        List<Descuento> descuentos = descuentoDAO.obtenerDescuentos();
        assertNotNull(descuentos);
        assertFalse(descuentos.isEmpty());
    }

    @Test
    public void testBuscarDescuento() {
        Descuento descuento = new Descuento();
        descuento.setCodigo("99887766");
        descuento.setNombre("DescuentoEspecial");
        descuento.setPorcentajeDescuento(BigDecimal.valueOf(15));
        descuento.setStock(25);

        descuentoDAO.guardarDescuento(descuento);

        List<Descuento> resultados = descuentoDAO.buscarDescuento("nombre", "Especial");
        assertNotNull(resultados);
        assertFalse(resultados.isEmpty());
        assertTrue(resultados.stream().anyMatch(d -> d.getNombre().contains("Especial")));
    }

    @Test
    public void testObtenerDescuentoPorId() {
        Descuento descuento = new Descuento();
        descuento.setCodigo("123123");
        descuento.setNombre("DescuentoPorId");
        descuento.setPorcentajeDescuento(BigDecimal.valueOf(20));
        descuento.setStock(30);

        descuentoDAO.guardarDescuento(descuento);

        Descuento descuentoObtenido = descuentoDAO.obtenerDescuentoPorId(descuento.getId());
        assertNotNull(descuentoObtenido);
        assertEquals("DescuentoPorId", descuentoObtenido.getNombre());
    }
}
