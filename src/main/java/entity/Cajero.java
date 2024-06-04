package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "cajero")
public class Cajero extends Usuario{
    @ManyToOne(fetch = FetchType.LAZY)
    private Usuario usuarioNumeroCedula;

    public Usuario getUsuarioNumeroCedula() {
        return usuarioNumeroCedula;
    }

    public void setUsuarioNumeroCedula(Usuario usuarioNumeroCedula) {
        this.usuarioNumeroCedula = usuarioNumeroCedula;
    }
}
