<%@ page import="java.util.List" %>
<%@ page import="dao.ProductoDAO" %>
<%@ page import="entity.Producto" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gesti&oacute;n de Inventario</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>

<h1>Gesti&oacute;n de Inventario</h1>

<h2>Buscar Producto</h2>
<form id="searchForm">
    <label for="filtro">Filtrar por:</label>
    <select id="filtro" name="filtro">
        <option value="nombre">Nombre</option>
        <option value="precio">Precio</option>
        <option value="marca">Marca</option>
        <option value="garantia">Garantía</option>
        <option value="stock">Stock</option>
    </select>
    <label for="terminoBusqueda">Término de búsqueda:</label>
    <input type="text" id="terminoBusqueda" name="terminoBusqueda">
    <button type="submit">Buscar</button>
</form>

<h2>Inventario Actual</h2>
<table id="productos">
    <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Precio</th>
        <th>Marca</th>
        <th>Garantía</th>
        <th>Stock</th>
    </tr>
    <%
        ProductoDAO productoDAO = new ProductoDAO();
        List<Producto> productos = productoDAO.obtenerProductos();

        for (Producto producto : productos) {
    %>
    <tr>
        <td><%= producto.getId()%></td>
        <td><%= producto.getNombreProducto() %></td>
        <td><%= producto.getPrecio() %></td>
        <td><%= producto.getMarca() %></td>
        <td><%= producto.getGarantia() %></td>
        <td><%= producto.getStock() %></td>
    </tr>
    <% } %>
</table>

<br>

<button id="agregarProductoBtn">Agregar Producto</button>

<!-- Modal for adding product -->
<div id="modalAgregarProducto" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Ingresar Detalles del Producto</h2>
        <form id="agregarProductoForm" action="agregarProducto" method="post">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required><br>
            <label for="precio">Precio:</label>
            <input type="number" id="precio" name="precio" step="0.01" required><br>
            <label for="marca">Marca:</label>
            <input type="text" id="marca" name="marca" required><br>
            <label for="garantia">Garantía:</label>
            <select id="garantia" name="garantia">
                <option value="1">1 año</option>
                <option value="2">2 años</option>
                <option value="3">3 años</option>
                <option value="4">4 años</option>
                <option value="5">5 años</option>
            </select><br>
            <label for="stock">Stock:</label>
            <input type="number" id="stock" name="stock" required><br>
            <button type="submit">Agregar</button>
            <button type="button" onclick="window.close()">Cancelar</button>
        </form>
    </div>
</div>

<button id="actualizarProductoBtn">Actualizar Producto</button>

<button id="eliminarProductoBtn">Eliminar Producto</button>

<button type="button" onclick="window.location.href='inicio.jsp'">Volver</button>

<script>
    document.getElementById('searchForm').addEventListener('submit', function(event) {
        event.preventDefault();
        var filtro = document.getElementById('filtro').value;
        var terminoBusqueda = document.getElementById('terminoBusqueda').value;
        var url = 'buscarProducto?filtro=' + filtro + '&terminoBusqueda=' + terminoBusqueda;
        fetch(url)
            .then(response => response.json())
            .then(data => {
                var table = document.getElementById('productos');
                table.innerHTML = '';
                var headerRow = table.insertRow();
                var headers = ['ID', 'Nombre', 'Precio', 'Marca', 'Garantía', 'Stock'];
                headers.forEach(headerText => {
                    var headerCell = document.createElement('th');
                    headerCell.textContent = headerText;
                    headerRow.appendChild(headerCell);
                });
                data.forEach(producto => {
                    var row = table.insertRow();
                    row.insertCell(0).textContent = producto.id;
                    row.insertCell(1).textContent = producto.nombre;
                    row.insertCell(2).textContent = producto.precio;
                    row.insertCell(3).textContent = producto.marca;
                    row.insertCell(4).textContent = producto.garantia;
                    row.insertCell(5).textContent = producto.stock;
                });
            });
    });

    var modal = document.getElementById('modalAgregarProducto');
    var btn = document.getElementById('agregarProductoBtn');
    var span = document.getElementsByClassName('close')[0];

    btn.onclick = function() {
        modal.style.display = 'block';
    }

    span.onclick = function() {
        modal.style.display = 'none';
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }
</script>

<script>
    var modalAgregar = document.getElementById('modalAgregarProducto');
    var btnAgregar = document.getElementById('agregarProductoBtn');
    var btnActualizar = document.getElementById('actualizarProductoBtn');
    var btnEliminar = document.getElementById('eliminarProductoBtn');

    btnAgregar.onclick = function() {
        modalAgregar.style.display = 'block';
    }

    btnActualizar.onclick = function() {
        var id = prompt("Ingrese el ID del producto que desea actualizar:");
        if (id) {
            window.location.href = 'formularioActualizarProducto.jsp?id=' + id;
        }
    }

    btnEliminar.onclick = function() {
        var id = prompt("Ingrese el ID del producto que desea eliminar:");
        if (id) {
            window.location.href = 'formularioEliminarProducto.jsp?id=' + id;
        }
    }
</script>

</body>
</html>

