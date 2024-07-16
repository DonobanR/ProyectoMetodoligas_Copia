<%--
  Created by IntelliJ IDEA.
  User: USUARIO
  Date: 15/7/2024
  Time: 1:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ventas</title>
</head>
<body>
<h2>Modulo de Ventas</h2>

<!-- Sección para seleccionar cliente -->
<h3>Seleccionar Cliente</h3>
<select id="clientes" onchange="mostrarCliente()">
    <option value="">Seleccione un cliente</option>
</select>
<div id="datosCliente">
    <p>Nombre: <span id="nombreCliente"></span></p>
    <p>Apellido: <span id="apellidoCliente"></span></p>
    <p>Dirección: <span id="direccionCliente"></span></p>
    <p>Correo: <span id="correoCliente"></span></p>
</div>

<!-- Sección para seleccionar producto -->
<h3>Agregar Producto</h3>
<select id="productos">
    <option value="">Seleccione un producto</option>
</select>
<input type="number" id="cantidad" placeholder="Cantidad" min="1">
<button onclick="agregarProducto()">Agregar Producto</button>

<!-- Tabla para mostrar productos agregados -->
<h3>Productos en la Venta</h3>
<table id="tablaVentas">
    <thead>
    <tr>
        <th>Nombre Producto</th>
        <th>Cantidad</th>
        <th>Precio</th>
        <th>Marca</th>
        <th>Total</th>
    </tr>
    </thead>
    <tbody>
    <!-- Productos se agregarán aquí -->
    </tbody>
</table>

<!-- Total de la venta -->
<h3>Total: $<span id="totalVenta">0.00</span></h3>

<!-- Script JS para manejar la interacción del usuario -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        cargarClientes();
        cargarProductos();
    });

    function cargarClientes() {
        fetch('obtenerClientes')
            .then(response => response.json())
            .then(clientes => {
                let clientesSelect = document.getElementById('clientes');
                clientes.forEach(cliente => {
                    let option = document.createElement('option');
                    option.value = cliente.id;
                    option.text = cliente.id;
                    clientesSelect.appendChild(option);
                });
            })
            .catch(error => console.error('Error al cargar clientes:', error));
    }

    function cargarProductos() {
        fetch('obtenerProductos')
            .then(response => response.json())
            .then(productos => {
                let productosSelect = document.getElementById('productos');
                productos.forEach(producto => {
                    let option = document.createElement('option');
                    option.value = producto.id;
                    option.text = producto.id;
                    productosSelect.appendChild(option);
                });
            })
            .catch(error => console.error('Error al cargar productos:', error));
    }

    function mostrarCliente() {
        let clienteId = document.getElementById('clientes').value;
        if (clienteId) {
            fetch(`obtenerClientePorCedula?numeroCedula=${clienteId}`)
                .then(response => response.json())
                .then(cliente => {
                    if (cliente) {
                        document.getElementById('nombreCliente').innerText = cliente.nombre;
                        document.getElementById('apellidoCliente').innerText = cliente.apellido;
                        document.getElementById('direccionCliente').innerText = cliente.direccion;
                        document.getElementById('correoCliente').innerText = cliente.correo;
                    } else {
                        console.error('Cliente no encontrado');
                    }
                })
                .catch(error => console.error('Error al obtener cliente:', error));
        }
    }

    function agregarProducto() {
        let productosSelect = document.getElementById('productos');
        let idProducto = productosSelect.value;
        let cantidad = document.getElementById('cantidad').value;

        if (idProducto && cantidad) {
            fetch(`buscarProducto?id=${idProducto}`)
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(error => {
                            throw new Error(error.error);
                        });
                    }
                    return response.json();
                })
                .then(producto => {
                    let tablaVentas = document.getElementById('tablaVentas').getElementsByTagName('tbody')[0];
                    let row = tablaVentas.insertRow();
                    row.insertCell(0).innerText = producto.nombreProducto;
                    row.insertCell(1).innerText = cantidad;
                    row.insertCell(2).innerText = producto.precio;
                    row.insertCell(3).innerText = producto.marca;
                    row.insertCell(4).innerText = (producto.precio * cantidad).toFixed(2);

                    actualizarTotalVenta();
                })
                .catch(error => console.error('Error al buscar producto:', error));
        }
    }

    function actualizarTotalVenta() {
        let tablaVentas = document.getElementById('tablaVentas').getElementsByTagName('tbody')[0];
        let total = 0;
        for (let i = 0; i < tablaVentas.rows.length; i++) {
            total += parseFloat(tablaVentas.rows[i].cells[4].innerText);
        }
        document.getElementById('totalVenta').innerText = total.toFixed(2);
    }
</script>

</body>
</html>