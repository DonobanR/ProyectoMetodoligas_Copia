package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "factura")
public class Factura {
    @Id
    @Column(name = "idFactura", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "idVenta", nullable = false)
    private Venta idVenta;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Venta getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(Venta idVenta) {
        this.idVenta = idVenta;
    }

    public boolean generarPDF() {
        return true;
    }
}