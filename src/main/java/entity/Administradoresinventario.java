package entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "administradoresinventario")
public class Administradoresinventario extends Usuario {
    @OneToMany(mappedBy = "supervisor", cascade = CascadeType.ALL)
    private List<Cajero> cajeros;

    public List<Cajero> getCajeros() {
        return cajeros;
    }

    public void setCajeros(List<Cajero> cajeros) {
        this.cajeros = cajeros;
    }
}