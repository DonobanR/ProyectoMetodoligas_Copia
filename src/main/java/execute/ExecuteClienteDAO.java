package execute;

import dao.ClienteDAO;
import entity.Cliente;

public class ExecuteClienteDAO {
    public static void main(String[] args) {
        ClienteDAO clienteDAO = new ClienteDAO();

        //Agregar Cliente
        Cliente nuevoCliente = new Cliente();
        nuevoCliente.setId(1234567889);
        nuevoCliente.setNombre("Alexander");
        nuevoCliente.setApellido("Tibantaaa");
        nuevoCliente.setDireccion("La Peaña y Caracol");
        nuevoCliente.setCorreo("alexander.tibanta@severeg.com");

        //Actualizar Cliente Existente
        Cliente clienteExistente = clienteDAO.obtenerClientePorCedula(1234567889);
        clienteExistente.setApellido("Tibanta");
        clienteDAO.actualizarCliente(clienteExistente);

        //Eliminar Cliente Existente
        //Cliente clienteAEliminar = clienteDAO.obtenerClientePorCedula(1234567889);
        //clienteDAO.eliminarCliente(clienteAEliminar);
    }
}
