package entity;

import jakarta.persistence.*;

@Entity
@DiscriminatorValue("Cajero")
public class Cajero extends Usuario{
    @Id
    @Column(name = "numeroCedula", nullable = false, length = 20)
    private Integer numeroCedula;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "numeroCedula", nullable = false)
    private Usuario usuarios;

    public Integer getNumeroCedula() {
        return numeroCedula;
    }

    public void setNumeroCedula(String numeroCedula) {
        this.numeroCedula = Integer.valueOf(numeroCedula);
    }

    public Usuario getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(Usuario usuarios) {
        this.usuarios = usuarios;
    }

}