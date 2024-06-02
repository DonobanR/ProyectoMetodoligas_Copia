<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.ProductoDAO" %>
<%@ page import="entity.Producto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.DescuentoDAO" %>
<%@ page import="entity.Descuento" %>
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
    </style>
</head>
<body>
<h1>Descuentos</h1>

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
        <td><%= descuento.getCodigo() %></td>
        <td><%= descuento.getNombre() %></td>
        <td><%= descuento.getPorcentajeDescuento() %></td>
        <td><%= descuento.getStock() %></td>
    </tr>
    <% } %>
</table>

<button onclick="mostrarFormulario()">Agregar Descuento</button>

<script>
    function mostrarFormulario() {
        window.open('formularioAgregarDescuento.jsp', 'Agregar Descuento', 'width=400,height=400');
    }
    document.getElementById('searchForm').addEventListener('submit', function(event) {
        event.preventDefault(); // Evita que se recargue la página al enviar el formulario
        var filtro = document.getElementById('filtro').value;
        var terminoBusqueda = document.getElementById('terminoBusqueda').value;
        var url = 'buscarDescuento?filtro=' + filtro + '&terminoBusqueda=' + terminoBusqueda;
        fetch(url)
            .then(response => response.json())
            .then(data => {
                // Limpiar la tabla actual
                var table = document.getElementById('descuentos');
                table.innerHTML = '';
                // Agregar los encabezados de columna con estilo en negrita
                var headerRow = table.insertRow();
                var headers = ['Código', 'Nombre', 'Porcentaje Descuento', 'Stock'];
                headers.forEach(headerText => {
                    var headerCell = document.createElement('th');
                    headerCell.textContent = headerText;
                    headerCell.style.fontWeight = 'bold'; // Aplica negrita
                    headerRow.appendChild(headerCell);
                });
                // Agregar los nuevos descuentos a la tabla
                data.forEach(descuento => {
                    var row = table.insertRow();
                    row.insertCell(0).textContent = descuento.codigo;
                    row.insertCell(1).textContent = descuento.nombre;
                    row.insertCell(2).textContent = descuento.porcentajeDescuento;
                    row.insertCell(3).textContent = descuento.stock;
                });
            });
    });
</script>

</body>
</html>