<%--
  Created by IntelliJ IDEA.
  User: USUARIO
  Date: 16/7/2024
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Venta" %>
<%@ page import="entity.DetallesVenta" %>
<html>
<head>
    <title>Lista de Ventas</title>
</head>
<body>
<h2>Lista de Ventas</h2>

<!-- Botón para cargar las ventas -->
<form action="obtenerVentas" method="get">
    <input type="submit" value="Cargar Ventas">
</form>

<table border="1">
    <thead>
    <tr>
        <th>ID Venta</th>
        <th>Fecha</th>
        <th>Total</th>
        <th>Detalles</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Venta> ventas = (List<Venta>) request.getAttribute("ventas");
        if (ventas != null) {
            for (Venta venta : ventas) {
    %>
    <tr>
        <td><%= venta.getIdVenta() %></td>
        <td><%= venta.getFecha() %></td>
        <td><%= venta.getTotal() %></td>
        <td>
            <table border="1">
                <thead>
                <tr>
                    <th>ID Detalle</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Total</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<DetallesVenta> detalles = venta.getDetalles();
                    if (detalles != null) {
                        for (DetallesVenta detalle : detalles) {
                %>
                <tr>
                    <td><%= detalle.getIdDetalle() %></td>
                    <td><%= detalle.getCantidad() %></td>
                    <td><%= detalle.getPrecio() %></td>
                    <td><%= detalle.getTotal() %></td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
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