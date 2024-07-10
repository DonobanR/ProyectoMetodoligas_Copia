package entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "ventas")
public class Venta {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idVenta", nullable = false)
    private Integer idVenta;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "numeroCedula", nullable = false) // Asumo que numeroCedula es el ID del Cajero
    private Cajero cajero;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cedulaCliente", nullable = false) // Asumo que cedulaCliente es la cédula del Cliente
    private Cliente cliente;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idDescuento")
    private Descuento descuento;

    @Column(name = "numeroProductos", nullable = false)
    private Integer numeroProductos;

    @Column(name = "totalVenta", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalVenta;

    public Integer getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(Integer idVenta) {
        this.idVenta = idVenta;
    }

    public Cajero getCajero() {
        return cajero;
    }

    public void setCajero(Cajero cajero) {
        this.cajero = cajero;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Descuento getDescuento() {
        return descuento;
    }

    public void setDescuento(Descuento descuento) {
        this.descuento = descuento;
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