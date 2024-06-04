package dao;

import entity.Descuento;

import java.math.BigDecimal;

public class ExecuteDescuentoDAO {
    public static void main(String[] args) {
        DescuentoDAO descuentoDAO = new DescuentoDAO();

        //Agregar Descuento
        Descuento nuevoDescuento = new Descuento();
        nuevoDescuento.setCodigo("696969");
        nuevoDescuento.setNombre("Descuento111");
        nuevoDescuento.setPorcentajeDescuento(BigDecimal.valueOf(70));
        nuevoDescuento.setStock(5);
        descuentoDAO.guardarDescuento(nuevoDescuento);

        //Actualizar Descuento existente
        Descuento descuentoExistente = descuentoDAO.obtenerDescuentoPorId(12);
        descuentoExistente.setNombre("DescuentoR");
        descuentoDAO.actualizarDescuento(descuentoExistente);

        //Eliminar Descuento existente
        Descuento descuentoAEliminar = descuentoDAO.obtenerDescuentoPorId(8);
        descuentoDAO.eliminarDescuento(descuentoAEliminar);
    }
}