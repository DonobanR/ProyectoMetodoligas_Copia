<%@ page import="java.util.List" %>
<%@ page import="dao.DescuentoDAO" %>
<%@ page import="entity.Descuento" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gesti&oacute;n de Descuentos</title>
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

<h1>Gesti&oacute;n de Descuentos</h1>

<h2>Buscar Descuento</h2>
<form id="searchForm">
    <label for="filtro">Filtrar por:</label>
    <select id="filtro" name="filtro">
        <option value="codigo">Código</option>
        <option value="nombre">Nombre</option>
        <option value="porcentajeDescuento">Porcentaje Descuento</option>
        <option value="stock">Stock</option>
    </select>
    <label for="terminoBusqueda">Término de búsqueda:</label>
    <input type="text" id="terminoBusqueda" name="terminoBusqueda">
    <button type="submit">Buscar</button>
</form>

<h2>Descuentos Actuales</h2>
<table id="descuentos">
    <tr>
        <th>ID</th>
        <th>Código</th>
        <th>Nombre</th>
        <th>Porcentaje Descuento</th>
        <th>Stock</th>
    </tr>
    <%
        DescuentoDAO descuentoDAO = new DescuentoDAO();
        List<Descuento> descuentos = descuentoDAO.obtenerDescuentos();

        for (Descuento descuento : descuentos) {
    %>
    <tr>
        <td><%= descuento.getId()%></td>
        <td><%= descuento.getCodigo() %></td>
        <td><%= descuento.getNombre() %></td>
        <td><%= descuento.getPorcentajeDescuento() %></td>
        <td><%= descuento.getStock() %></td>
    </tr>
    <% } %>
</table>

<br>

<button id="agregarDescuentoBtn">Agregar Descuento</button>

<!-- Modal for adding Descuentos-->
<div id="modalAgregarDescuento" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Ingresar Detalles del Descuento</h2>
        <form id="agregarDescuentoForm" action="agregarDescuento" method="post">
            <label for="codigo">Código:</label>
            <input type="text" id="codigo" name="codigo" required><br>
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required><br>
            <label for="porcentajeDescuento">Descuento %:</label>
            <select id="porcentajeDescuento" name="porcentajeDescuento">
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="35">35</option>
                <option value="40">40</option>
                <option value="50">50</option>
            </select><br>
            <label for="stock">Stock:</label>
            <input type="number" id="stock" name="stock" required><br>
            <button type="submit">Agregar</button>
            <button type="button" onclick="window.close()">Cancelar</button>
        </form>
    </div>
</div>

<button id="actualizarDescuentoBtn">Actualizar Descuento</button>

<button id="eliminarDescuentoBtn">Eliminar Descuento</button>

<button >Regresar</button>

<script>
    document.getElementById('searchForm').addEventListener('submit', function(event) {
        event.preventDefault();
        var filtro = document.getElementById('filtro').value;
        var terminoBusqueda = document.getElementById('terminoBusqueda').value;
        var url = 'buscarDescuento?filtro=' + filtro + '&terminoBusqueda=' + terminoBusqueda;
        fetch(url)
            .then(response => response.json())
            .then(data => {
                var table = document.getElementById('descuentos');
                table.innerHTML = '';
                var headerRow = table.insertRow();
                var headers = ['ID', 'Código', 'Nombre', 'Porcentaje Descuento', 'Stock'];
                headers.forEach(headerText => {
                    var headerCell = document.createElement('th');
                    headerCell.textContent = headerText;
                    headerRow.appendChild(headerCell);
                });
                data.forEach(descuento => {
                    var row = table.insertRow();
                    row.insertCell(0).textContent = descuento.id;
                    row.insertCell(1).textContent = descuento.codigo;
                    row.insertCell(2).textContent = descuento.nombre;
                    row.insertCell(3).textContent = descuento.porcentajeDescuento;
                    row.insertCell(4).textContent = descuento.stock;
                });
            });
    });

    var modal = document.getElementById('modalAgregarDescuento');
    var btn = document.getElementById('agregarDescuentoBtn');
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
    var modalAgregar = document.getElementById('modalAgregarDescuento');
    var btnAgregar = document.getElementById('agregarDescuentoBtn');
    var btnActualizar = document.getElementById('actualizarDescuentoBtn');
    var btnEliminar = document.getElementById('eliminarDescuentoBtn');

    btnAgregar.onclick = function() {
        modalAgregar.style.display = 'block';
    }

    btnActualizar.onclick = function() {
        var id = prompt("Ingrese el ID del descuento que desea actualizar:");
        if (id) {
            window.location.href = 'formularioActualizarDescuento.jsp?id=' + id;
        }
    }

    btnEliminar.onclick = function() {
        var id = prompt("Ingrese el ID del producto que desea eliminar:");
        if (id) {
            window.location.href = 'formularioEliminarDescuento.jsp?id=' + id;
        }
    }
</script>

</body>
</html>