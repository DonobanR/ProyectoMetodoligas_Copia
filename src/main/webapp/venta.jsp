<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Venta</title>
    <script>
        // Función para llenar dinámicamente los clientes y productos al cargar la página
        window.onload = function() {
            obtenerClientes();
            obtenerProductos();
        };

        function obtenerClientes() {
            fetch('obtenerClientes')
                .then(response => response.json())
                .then(data => {
                    var select = document.getElementById('idCliente');
                    select.innerHTML = '';
                    data.forEach(cliente => {
                        var option = document.createElement('option');
                        option.value = cliente.id;
                        option.textContent = cliente.id;
                        select.appendChild(option);
                    });
                })
                .catch(error => console.error('Error al obtener la lista de clientes:', error));
        }

        function obtenerProductos() {
            fetch('obtenerProductos')
                .then(response => response.json())
                .then(data => {
                    var select = document.getElementById('idProducto');
                    select.innerHTML = '';
                    data.forEach(producto => {
                        var option = document.createElement('option');
                        option.value = producto.id;
                        option.textContent = producto.id;
                        select.appendChild(option);
                    });
                })
                .catch(error => console.error('Error al obtener la lista de productos:', error));
        }

        function agregarProducto() {
            var idProducto = document.getElementById('idProducto').options[document.getElementById('idProducto').selectedIndex].value;
            var cantidad = document.getElementById('cantidad').value;
            var table = document.getElementById('tablaProductos').getElementsByTagName('tbody')[0];

            fetch(`buscarProducto?id=${idProducto}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json(); // Parsea la respuesta como JSON
                })
                .then(producto => {
                    console.log('Producto recibido:', producto); // Loguea el producto recibido para verificar

                    // Inserta una nueva fila en la tabla
                    var row = table.insertRow();
                    row.insertCell(0).textContent = producto.nombreProducto; // Ajusta según la estructura del objeto recibido
                    row.insertCell(1).textContent = cantidad;
                    row.insertCell(2).textContent = producto.precio.toFixed(2); // Ajusta según la estructura del objeto recibido
                    row.insertCell(3).textContent = (producto.precio * cantidad).toFixed(2); // Calcula el total y formatea

                    // Actualiza los totales después de agregar el producto
                    actualizarTotales();
                })
                .catch(error => console.error('Error al obtener el producto:', error));
        }






        function actualizarTotales() {
            var table = document.getElementById('tablaProductos').getElementsByTagName('tbody')[0];
            var subtotal = 0;
            for (var i = 0, row; row = table.rows[i]; i++) {
                subtotal += parseFloat(row.cells[3].textContent);
            }
            document.getElementById('subtotal').textContent = subtotal.toFixed(2);
            document.getElementById('totalIVA').textContent = (subtotal * 1.15).toFixed(2);
        }

        function generarVenta() {
            // Implementar la lógica para generar la venta
        }
    </script>
</head>
<body>
<h1>Registrar Venta</h1>
<div>
    <label for="idCliente">Seleccionar Cliente:</label>
    <select id="idCliente">
        <!-- Aquí se llenarán dinámicamente los clientes -->
    </select>
</div>
<div>
    <label for="idProducto">Seleccionar Producto:</label>
    <select id="idProducto">
        <!-- Las opciones de los productos se llenarán dinámicamente desde JavaScript -->
    </select>
    <label for="cantidad">Cantidad:</label>
    <input type="number" id="cantidad" min="1">
    <button onclick="agregarProducto()">Agregar Producto</button>
</div>

<table id="tablaProductos" border="1">
    <thead>
    <tr>
        <th>Nombre del Producto</th>
        <th>Cantidad</th>
        <th>Precio</th>
        <th>Precio Total Unitario</th>
    </tr>
    </thead>
    <tbody>
    <!-- Aquí se agregarán dinámicamente las filas de productos -->
    </tbody>
</table>
<div>
    <p>Subtotal: <span id="subtotal">0.00</span></p>
    <p>Total IVA (15%): <span id="totalIVA">0.00</span></p>
</div>
<div>
    <label for="idDescuento">Descuentos disponibles:</label>
    <ul id="idDescuento">
        <!-- Aquí se llenarán dinámicamente los descuentos -->
    </ul>
</div>
<button onclick="generarVenta()">Generar Venta</button>
</body>
</html>
