package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "usuario")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "tipo_usuario", discriminatorType = DiscriminatorType.STRING)
public class Usuario {
    @Id
    @Column(name = "numeroCedula", nullable = false, length = 20)
    private Integer numeroCedula;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "apellido", nullable = false)
    private String apellido;

    @Column(name = "direccion")
    private String direccion;

    @Column(name = "correo")
    private String correo;

    private String usuarioIn = "usuario1";
    private String contrasenaIn = "contrasena1";


    //Incremento del test
    public boolean iniciarSesion(String usuario, String contrasena) {
        return this.usuarioIn.equals(usuario) &&
                this.contrasenaIn.equals(contrasena);
    }

    public boolean verificarCedula() {
        return true;
    }
    public Integer getNumeroCedula() {
        return numeroCedula;
    }

    public void setNumeroCedula(String numeroCedula) {
        this.numeroCedula = Integer.valueOf(numeroCedula);
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }


}