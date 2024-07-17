package execute;

import dao.VentaDAO;
import entity.Venta;
import java.util.List;

public class TestVentaDAO {
    public static void main(String[] args) {
        VentaDAO ventaDAO = new VentaDAO();
        List<Venta> ventas = ventaDAO.obtenerVentas();

        if (ventas != null) {
            for (Venta venta : ventas) {
                System.out.println("ID Venta: " + venta.getIdVenta());
                System.out.println("Cliente: " + venta.getCliente().getId());
                System.out.println("Fecha: " + venta.getFecha());
                System.out.println("Total: " + venta.getTotal());
            }
        } else {
            System.out.println("No se encontraron ventas.");
        }
    }
}