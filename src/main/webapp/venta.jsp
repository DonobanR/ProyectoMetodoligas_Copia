<%--
  Created by IntelliJ IDEA.
  User: USUARIO
  Date: 15/7/2024
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Módulo de Ventas</title>
    <style>
        /* Estilo para el módulo de ventas */
        .section {
            margin-bottom: 20px;
        }
        .section h2 {
            margin-bottom: 10px;
        }
        .table-container {
            margin-top: 20px;
        }
        .product-table, .client-table {
            width: 100%;
            border-collapse: collapse;
        }
        .product-table th, .product-table td, .client-table th, .client-table td {
            border: 1px solid #ddd;
            padding: 8px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        let productos = [];
        let clientes = [];
        let venta = [];

        $(document).ready(function() {
            // Obtener productos existentes
            $.getJSON("obtenerProductosVenta", function(data) {
                productos = data;
                productos.forEach(function(producto) {
                    $('#producto').append(`<option value="${producto.id}">${producto.nombreProducto}</option>`);
                });
            });

            // Obtener clientes existentes
            $.getJSON("obtenerClientes", function(data) {
                clientes = data;
                clientes.forEach(function(cliente) {
                    $('#cliente').append(`<option value="${cliente.id}">${cliente.nombre} ${cliente.apellido}</option>`);
                });
            });

            // Agregar producto a la tabla de ventas
            $('#agregarProducto').click(function() {
                const productoId = $('#producto').val();
                const cantidad = $('#cantidad').val();
                const producto = productos.find(p => p.id == productoId);

                if (producto && cantidad > 0) {
                    const total = producto.precio * cantidad;
                    venta.push({ ...producto, cantidad, total });

                    let fila = `
                        <tr>
                            <td>${producto.nombreProducto}</td>
                            <td>${cantidad}</td>
                            <td>${producto.precio}</td>
                            <td>${producto.marca}</td>
                            <td>${total}</td>
                        </tr>`;
                    $('#tablaVentas tbody').append(fila);
                    actualizarTotal();
                } else {
                    alert("Selecciona un producto y una cantidad válida.");
                }
            });

            // Mostrar datos del cliente seleccionado
            $('#cliente').change(function() {
                const clienteId = $(this).val();
                const cliente = clientes.find(c => c.id == clienteId);

                if (cliente) {
                    $('#datosCliente').html(`
                        <p>Nombre: ${cliente.nombre} ${cliente.apellido}</p>
                        <p>Dirección: ${cliente.direccion}</p>
                        <p>Correo: ${cliente.correo}</p>
                    `);
                }
            });

            function actualizarTotal() {
                const totalVenta = venta.reduce((acc, prod) => acc + prod.total, 0);
                $('#totalVenta').text(`Total Venta: $${totalVenta}`);
            }
        });
    </script>
</head>
<body>
<div class="section">
    <h2>Seleccione Productos</h2>
    <select id="producto">
        <option value="">Seleccione un producto</option>
    </select>
    <input type="number" id="cantidad" placeholder="Cantidad">
    <button id="agregarProducto">Agregar Producto</button>
</div>

<div class="table-container">
    <h2>Detalle de Venta</h2>
    <table id="tablaVentas" class="product-table">
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
        <!-- Productos agregados aparecerán aquí -->
        </tbody>
    </table>
    <p id="totalVenta">Total Venta: $0</p>
</div>

<div class="section">
    <h2>Seleccione Cliente</h2>
    <select id="cliente">
        <option value="">Seleccione un cliente</option>
    </select>
    <div id="datosCliente">
        <!-- Datos del cliente seleccionado aparecerán aquí -->
    </div>
</div>
</body>
</html>