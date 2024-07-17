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
    <title>Lista de Facturas</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">
<div class="container mx-auto p-4">
    <h2 class="text-2xl font-bold mb-4">Lista de Facturas</h2>

    <!-- Botón para cargar las ventas -->
    <form action="obtenerVentas" method="get" class="mb-4">
        <input type="submit" value="Cargar Ventas" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
    </form>

    <!-- Formulario para buscar una venta por ID -->
    <form action="buscarVenta" method="get" class="mb-4">
        <label for="idVenta" class="block text-sm font-medium text-gray-700">ID Venta:</label>
        <input type="text" id="idVenta" name="idVenta" class="mt-1 p-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 block w-full sm:text-sm">
        <input type="submit" value="Buscar Venta" class="mt-2 bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
    </form>

    <table class="min-w-full bg-white border-collapse block md:table">
        <thead class="block md:table-header-group">
        <tr class="border border-gray-300 md:border-none block md:table-row absolute -top-full md:top-auto -left-full md:left-auto md:relative">
            <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">ID Venta</th>
            <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">Fecha</th>
            <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">Total</th>
            <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">Detalles</th>
        </tr>
        </thead>
        <tbody class="block md:table-row-group">
        <%
            List<Venta> ventas = (List<Venta>) request.getAttribute("ventas");
            Venta venta = (Venta) request.getAttribute("venta");
            if (ventas != null) {
                for (Venta v : ventas) {
        %>
        <tr class="bg-gray-100 border border-gray-300 md:border-none block md:table-row">
            <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= v.getIdVenta() %></td>
            <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= v.getFecha() %></td>
            <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= v.getTotal() %></td>
            <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell">
                <table class="min-w-full bg-white border-collapse block md:table">
                    <thead class="block md:table-header-group">
                    <tr class="border border-gray-300 md:border-none block md:table-row absolute -top-full md:top-auto -left-full md:left-auto md:relative">
                        <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">ID Detalle</th>
                        <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">Cantidad</th>
                        <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">Precio</th>
                        <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">Total</th>
                    </tr>
                    </thead>
                    <tbody class="block md:table-row-group">
                    <%
                        List<DetallesVenta> detalles = v.getDetalles();
                        if (detalles != null) {
                            for (DetallesVenta detalle : detalles) {
                    %>
                    <tr class="bg-gray-100 border border-gray-300 md:border-none block md:table-row">
                        <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= detalle.getIdDetalle() %></td>
                        <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= detalle.getCantidad() %></td>
                        <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= detalle.getPrecio() %></td>
                        <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= detalle.getTotal() %></td>
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
        } else if (venta != null) {
        %>
        <tr class="bg-gray-100 border border-gray-300 md:border-none block md:table-row">
            <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= venta.getIdVenta() %></td>
            <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= venta.getFecha() %></td>
            <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= venta.getTotal() %></td>
            <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell">
                <table class="min-w-full bg-white border-collapse block md:table">
                    <thead class="block md:table-header-group">
                    <tr class="border border-gray-300 md:border-none block md:table-row absolute -top-full md:top-auto -left-full md:left-auto md:relative">
                        <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">ID Detalle</th>
                        <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">Cantidad</th>
                        <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">Precio</th>
                        <th class="bg-gray-200 p-2 text-gray-600 font-bold md:border md:border-gray-300 text-left block md:table-cell">Total</th>
                    </tr>
                    </thead>
                    <tbody class="block md:table-row-group">
                    <%
                        List<DetallesVenta> detalles = venta.getDetalles();
                        if (detalles != null) {
                            for (DetallesVenta detalle : detalles) {
                    %>
                    <tr class="bg-gray-100 border border-gray-300 md:border-none block md:table-row">
                        <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= detalle.getIdDetalle() %></td>
                        <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= detalle.getCantidad() %></td>
                        <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= detalle.getPrecio() %></td>
                        <td class="p-2 md:border md:border-gray-300 text-left block md:table-cell"><%= detalle.getTotal() %></td>
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
        %>
        </tbody>
    </table>
</div>
</body>
</html>