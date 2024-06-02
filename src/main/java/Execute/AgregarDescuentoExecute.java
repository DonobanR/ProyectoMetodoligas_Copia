package Execute;

import entity.Descuento;
import dao.DescuentoDAO;

import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;

public class AgregarDescuentoExecute {

    public static void main(String[] args) {
        // Crear un objeto Descuento con los datos de prueba
        Descuento descuento = new Descuento();
        descuento.setCodigo("7896");
        descuento.setNombre("NOMORE200");
        descuento.setPorcentajeDescuento(new BigDecimal("10"));
        descuento.setStock(100);

        // Guardar el descuento en la base de datos
        DescuentoDAO descuentoDAO = new DescuentoDAO();
        descuentoDAO.guardarDescuento(descuento);

        System.out.println("Descuento agregado exitosamente.");
    }
}
