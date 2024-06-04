package entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "ventas")
public class Venta {
    @Id
    @Column(name = "idVenta", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "numeroCedula", nullable = false)
    private Cajero numeroCedula;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idDescuento")
    private Descuento idDescuento;

    @Column(name = "numeroProductos", nullable = false)
    private Integer numeroProductos;

    @Column(name = "totalVenta", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalVenta;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Cajero getNumeroCedula() {
        return numeroCedula;
    }

    public void setNumeroCedula(Cajero numeroCedula) {
        this.numeroCedula = numeroCedula;
    }

    public Descuento getIdDescuento() {
        return idDescuento;
    }

    public void setIdDescuento(Descuento idDescuento) {
        this.idDescuento = idDescuento;
    }

    public Integer getNumeroProductos() {
        return numeroProductos;
    }

    public void setNumeroProductos(Integer numeroProductos) {
        this.numeroProductos = numeroProductos;
    }

    public BigDecimal getTotalVenta() {
        return totalVenta;
    }

    public void setTotalVenta(BigDecimal totalVenta) {
        this.totalVenta = totalVenta;
    }

}