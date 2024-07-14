<%--
  Created by IntelliJ IDEA.
  User: Tibanta Alexander
  Date: 7/7/2024
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="dao.ClienteDAO" %>
<%@ page import="entity.Cliente" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Clientes</title>
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

<h1>Gestión de Clientes</h1>

<h2>Buscar Cliente</h2>
<form id="searchForm">
    <label for="filtro">Filtrar por:</label>
    <select id="filtro" name="filtro">
        <option value="numero_cedula">Número de Cédula</option>
        <option value="nombre">Nombre</option>
        <option value="apellido">Apellido</option>
        <option value="correo">Correo</option>
    </select>
    <label for="terminoBusqueda">Término de búsqueda:</label>
    <input type="text" id="terminoBusqueda" name="terminoBusqueda">
    <button type="submit">Buscar</button>
</form>

<h2>Clientes Actuales</h2>
<table id="clientes">
    <tr>
        <th>Numero C&eacute;dula</th>
        <th>Nombre</th>
        <th>Apellido</th>
        <th>Dirección</th>
        <th>Correo</th>
    </tr>
    <%
        ClienteDAO clienteDAO = new ClienteDAO();
        List<Cliente> clientes = clienteDAO.obtenerClientes();

        for (Cliente cliente : clientes) {
    %>
    <tr>
        <td><%= cliente.getId() %></td>
        <td><%= cliente.getNombre() %></td>
        <td><%= cliente.getApellido() %></td>
        <td><%= cliente.getDireccion() %></td>
        <td><%= cliente.getCorreo() %></td>
    </tr>
    <% } %>
</table>

<br>

<button id="agregarClienteBtn">Agregar Cliente</button>

<div id="modalAgregarCliente" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2> Ingresar Detalles del Cliente </h2>
        <form action="agregarCliente" method="post">
            <label for="numero_cedula">Cédula:</label>
            <input type="text" id="numero_cedula" name="numero_cedula" required>
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required>
            <label for="apellido">Apellido:</label>
            <input type="text" id="apellido" name="apellido" required>
            <label for="direccion">Dirección:</label>
            <input type="text" id="direccion" name="direccion">
            <label for="correo">Correo:</label>
            <input type="email" id="correo" name="correo" readonly>
            <button type="submit">Agregar Cliente</button>
        </form>
    </div>
</div>

<button id="actualizarClienteBtn">Actualizar Cliente</button>

<button id="eliminarClienteBtn">Eliminar Cliente</button>

<button type="button" onclick="window.location.href='inicio.jsp'">Volver</button>

<script>
    document.getElementById('nombre').addEventListener('blur', generarCorreo);
    document.getElementById('apellido').addEventListener('blur', generarCorreo);

    function generarCorreo() {
        var nombre = document.getElementById('nombre').value.toLowerCase();
        var apellido = document.getElementById('apellido').value.toLowerCase();
        if (nombre && apellido) {
            var correo = nombre + '.' + apellido + '@severeg.com';
            verificarCorreo(correo).then(resultado => {
                if (resultado.existe) {
                    var contador = 1;
                    while (resultado.existe) {
                        correo = nombre + '.' + apellido + (contador < 10 ? '0' + contador : contador) + '@severeg.com';
                        contador++;
                        resultado = verificarCorreo(correo);
                    }
                }
                document.getElementById('correo').value = correo;
            });
        }
    }

    function verificarCorreo(correo) {
        return fetch('verificarCorreo?correo=' + correo)
            .then(response => response.json());
    }
</script>

<script>
    document.getElementById('searchForm').addEventListener('submit', function (event){
        event.preventDefault();
        var filtro = document.getElementById('filtro').value;
        var terminoBusqueda = document.getElementById('terminoBusqueda').value;
        var url = 'buscarCliente?filtro=' + filtro + '&terminoBusqueda=' + terminoBusqueda;
        fetch(url)
            .then(response => response.json())
            .then(data => {
                var table = document.getElementById('clientes')
                table.innerHTML = '';
                var headerRow = table.insertRow();
                var headers = ['Numero C&eacute;dula', 'Nombre', 'Apellido', 'Direccion', 'Correo']
                headers.forEach(headerText => {
                    var headerCell = document.createElement('th');
                    headerCell.textContent = headerText;
                    headerRow.appendChild(headerCell);
                });
                data.forEach(cliente => {
                    var row = table.insertRow();
                    row.insertCell(0).textContent = cliente.numero_cedula;
                    row.insertCell(1).textContent = cliente.nombre;
                    row.insertCell(2).textContent = cliente.apellido;
                    row.insertCell(3).textContent = cliente.direccion;
                    row.insertCell(4).textContent = cliente.correo;

                });
            });
    });


    var modal = document.getElementById('modalAgregarCliente');
    var btn = document.getElementById('agregarClienteBtn');
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
    var modalAgregar = document.getElementById('modalAgregarCliente');
    var btnAgregar = document.getElementById('agregarClienteBtn');
    var btnActualizar = document.getElementById('actualizarClienteBtn');
    var btnEliminar = document.getElementById('eliminarClienteBtn');

    btnAgregar.onclick = function() {
        modalAgregar.style.display = 'block';
    }

    btnActualizar.onclick = function() {
        var id = prompt("Ingrese el Numero de Cedula del cliente que desea actualizar:");
        if (id) {
            window.location.href = 'formularioActualizarCliente.jsp?id=' + id;
        }
    }

    btnEliminar.onclick = function() {
        var id = prompt("Ingrese el Numero de Cedula del cliente que desea eliminar:");
        if (id) {
            window.location.href = 'formularioEliminarCliente.jsp?id=' + id;
        }
    }
</script>

</body>
</html>