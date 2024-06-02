package entity;

import jakarta.persistence.*;

@Entity
@DiscriminatorValue("Cliente")
public class Cliente extends Usuario {

    @Id
    @Column(name = "numeroCedula", nullable = false, length = 20)
    private Integer numeroCedula;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "numeroCedula", nullable = false)
    private Usuario usuario;

    public Integer getNumeroCedula() {
        return numeroCedula;
    }

    public void setNumeroCedula(Integer numeroCedula) {
        this.numeroCedula = numeroCedula;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

}