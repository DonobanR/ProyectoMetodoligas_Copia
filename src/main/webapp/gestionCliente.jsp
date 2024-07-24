<%@ page import="dao.ClienteDAO" %>
<%@ page import="entity.Cliente" %>
<%@ page import="java.util.List" %>
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

        .message {
            color: green;
            font-size: 0.9em;
        }

        .error-message {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>

<h1>Gestión de Clientes</h1>

<%
    String mensaje = request.getParameter("mensaje");
    if (mensaje != null) {
        if ("eliminacionExitosa".equals(mensaje)) {
%>
<p class="message">Cliente eliminado exitosamente.</p>
<%
} else if ("errorClienteNoEncontrado".equals(mensaje)) {
%>
<p class="error-message">No se encontró el cliente con el número de cédula proporcionado.</p>
<%
} else if ("errorNumeroCedula".equals(mensaje)) {
%>
<p class="error-message">El número de cédula no es válido.</p>
<%
} else if ("numeroCedulaFaltante".equals(mensaje)) {
%>
<p class="error-message">El número de cédula no fue proporcionado.</p>
<%
        }
    }
%>

<h2>Buscar Cliente</h2>
<form id="searchForm">
    <label for="filtro">Filtrar por:</label>
    <select id="filtro" name="filtro">
        <option value="id">Número de Cédula</option>
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
    <thead>
    <tr>
        <th>Numero Cédula</th>
        <th>Nombre</th>
        <th>Apellido</th>
        <th>Dirección</th>
        <th>Correo</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
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
        <td>
            <a href="formularioActualizarCliente.jsp?id=<%= cliente.getId() %>">Actualizar</a>
            <a href="#" onclick="eliminarCliente('<%= cliente.getId() %>')">Eliminar</a>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>

<!-- Botones para redirigir a las páginas de operaciones -->
<button onclick="window.location.href='formularioAgregarCliente.jsp'">Agregar Cliente</button>
<button type="button" onclick="window.location.href='inicio.jsp'">Volver</button>

<script>
    // Función de validación para entrada numérica
    function validateNumberInput(input) {
        let value = input.value.replace(/[^0-9]/g, '');

        // Limita la longitud a 10 dígitos
        if (value.length > 10) {
            value = value.substring(0, 10);
        }

        // Actualiza el valor del campo
        input.value = value;
    }

    // Listener para el formulario de búsqueda
    document.getElementById('searchForm').addEventListener('submit', function(event){
        event.preventDefault();
        var filtro = document.getElementById('filtro').value;
        var terminoBusqueda = document.getElementById('terminoBusqueda').value;
        var url = 'buscarCliente?filtro=' + encodeURIComponent(filtro) + '&terminoBusqueda=' + encodeURIComponent(terminoBusqueda);

        fetch(url)
            .then(response => response.json())
            .then(data => {
                var tableBody = document.querySelector('#clientes tbody');
                tableBody.innerHTML = ''; // Limpiar contenido anterior
                data.forEach(cliente => {
                    var row = tableBody.insertRow();
                    row.insertCell(0).textContent = cliente.id;
                    row.insertCell(1).textContent = cliente.nombre;
                    row.insertCell(2).textContent = cliente.apellido;
                    row.insertCell(3).textContent = cliente.direccion;
                    row.insertCell(4).textContent = cliente.correo;
                    var actionsCell = row.insertCell(5);
                    actionsCell.innerHTML = `
                        <a href="formularioActualizarCliente.jsp?id=${cliente.id}">Actualizar</a>
                        <a href="#" onclick="eliminarCliente('${cliente.id}')">Eliminar</a>
                    `;
                });
            })
            .catch(error => console.error('Error:', error));
    });

    // Función para eliminar cliente
    function eliminarCliente(id) {
        if (confirm('¿Está seguro de que desea eliminar este cliente?')) {
            fetch('eliminarCliente?id=' + encodeURIComponent(id), {
                method: 'POST'
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        window.location.href = 'gestionCliente.jsp?mensaje=eliminacionExitosa';
                    } else {
                        window.location.href = 'gestionCliente.jsp?mensaje=errorClienteNoEncontrado';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    window.location.href = 'gestionCliente.jsp?mensaje=errorNumeroCedula';
                });
        }
    }

</script>

</body>
</html>
