package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "administradoresinventario")
public class Administradoresinventario extends Usuario{
    @ManyToOne(fetch = FetchType.LAZY)
    private Usuario usuarioNumeroCedula;

    public Usuario getUsuarioNumeroCedula() {
        return usuarioNumeroCedula;
    }

    public void setUsuarioNumeroCedula(Usuario usuarioNumeroCedula) {
        this.usuarioNumeroCedula = usuarioNumeroCedula;
    }
}
