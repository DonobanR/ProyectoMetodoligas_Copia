package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "cliente")
@PrimaryKeyJoinColumn(name = "numero_cedula")
public class Cliente extends Usuario {

    // Aquí puedes agregar atributos específicos de Cliente si los hay

    public Cliente() {
        // Constructor vacío requerido por JPA
    }

    public Cliente(Integer numeroCedula, String nombre, String apellido, String direccion, String correo, String usuario, String contrasena) {
        this.setNumeroCedula(numeroCedula);
        this.setNombre(nombre);
        this.setApellido(apellido);
        this.setDireccion(direccion);
        this.setCorreo(correo);
        this.setUsuario(usuario);
        this.setContrasena(contrasena);
    }

    // Puedes agregar métodos adicionales si es necesario
}