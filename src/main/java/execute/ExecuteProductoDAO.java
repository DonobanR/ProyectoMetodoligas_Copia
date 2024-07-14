package execute;

import dao.ProductoDAO;
import entity.Producto;

import java.math.BigDecimal;

public class ExecuteProductoDAO {
    public static void main(String[] args) {
        ProductoDAO productoDAO = new ProductoDAO();

        //Agregar Nuevo producto
        Producto nuevoProducto = new Producto();
        nuevoProducto.setNombreProducto("Moto G");
        nuevoProducto.setPrecio(new BigDecimal("500.00"));
        nuevoProducto.setMarca("MOTOROLA");
        nuevoProducto.setGarantia("1 año");
        nuevoProducto.setStock(20);
        productoDAO.guardarProducto(nuevoProducto);

        //Actualizar Producto existente
        Producto productoExistente = productoDAO.obtenerProductoPorId(11);
        productoExistente.setGarantia("2 años");
        productoExistente.setPrecio(new BigDecimal("380.00"));
        productoDAO.actualizarProducto(productoExistente);

        //Eliminar Producto
        Producto productoAEliminar = productoDAO.obtenerProductoPorId(11); // Suponiendo que el producto con ID 2 existe
        productoDAO.eliminarProducto(productoAEliminar);
    }
}
