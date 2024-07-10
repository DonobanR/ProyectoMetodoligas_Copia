package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "cajero")
public class Cajero extends Usuario {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "usuarioNumeroCedula_numero_cedula")
    private Usuario supervisor;

    public Usuario getSupervisor() {
        return supervisor;
    }

    public void setSupervisor(Usuario supervisor) {
        this.supervisor = supervisor;
    }
}