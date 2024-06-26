package dao;

import entity.Descuento;

import java.math.BigDecimal;

public class ExecuteDescuentoDAO {
    public static void main(String[] args) {
        DescuentoDAO descuentoDAO = new DescuentoDAO();

        //Agregar Descuento
        Descuento nuevoDescuento = new Descuento();
        nuevoDescuento.setCodigo("231231");
        nuevoDescuento.setNombre("DescuentoBALL");
        nuevoDescuento.setPorcentajeDescuento(BigDecimal.valueOf(40));
        nuevoDescuento.setStock(15);
        descuentoDAO.guardarDescuento(nuevoDescuento);

        //Actualizar Descuento existente
        Descuento descuentoExistente = descuentoDAO.obtenerDescuentoPorId(4);
        descuentoExistente.setNombre("DescuentoASDGF");
        descuentoDAO.actualizarDescuento(descuentoExistente);

        //Eliminar Descuento existente
        Descuento descuentoAEliminar = descuentoDAO.obtenerDescuentoPorId(18);
        descuentoDAO.eliminarDescuento(descuentoAEliminar);
    }
}