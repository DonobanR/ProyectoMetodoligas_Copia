<%--
  Created by IntelliJ IDEA.
  User: dopar
  Date: 13/7/2024
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Facturas</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<h1>Gestión de Facturas</h1>

<form action="gestionarFacturas" method="get">
    <label for="criterio">Buscar por:</label>
    <select name="criterio" id="criterio">
        <option value="fecha">Fecha</option>
        <option value="cliente">Cliente</option>
        <option value="monto">Monto</option>
    </select>
    <input type="text" name="valor" id="valor">
    <button type="submit">Buscar</button>
</form>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Fecha</th>
        <th>Cliente</th>
        <th>Monto</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<entity.Factura> facturas = (List<entity.Factura>) request.getAttribute("facturas");
        if (facturas != null) {
            for (entity.Factura factura : facturas) {
    %>
    <tr>
        <td><%= factura.getId() %></td>
        <td><%= factura.getFecha() %></td>
        <td><%= factura.getCliente() %></td>
        <td><%= factura.getMonto() %></td>
        <td>
            <a href="editarFactura?id=<%= factura.getId() %>">Editar</a>
            <a href="eliminarFactura?id=<%= factura.getId() %>">Eliminar</a>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
</body>
</html>
