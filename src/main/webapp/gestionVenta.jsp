<%--
  Created by IntelliJ IDEA.
  User: USUARIO
  Date: 5/5/2024
  Time: 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="entity.Cliente, entity.Producto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ventas</title>
    <script>
        function fetchData(tipo) {
            var form = document.getElementById(tipo + 'Form');
            form.submit();
        }
    </script>
</head>
<body>
<h2>Formulario de Venta</h2>
<form id="clienteForm" action="fetchData" method="get">
    <input type="hidden" name="tipo" value="cliente"/>
    Cliente ID: <input type="text" name="clienteId" value="<%= request.getParameter("clienteId") != null ? request.getParameter("clienteId") : "" %>" />
    <button type="button" onclick="fetchData('cliente')">Buscar Cliente</button>
</form>
<h3>Datos del Cliente</h3>
<% if (request.getAttribute("cliente") != null) {
    Cliente cliente = (Cliente) request.getAttribute("cliente");
%>
Nombre: <input type="text" name="nombreCliente" value="<%= cliente.getNombre() %>" disabled><br/>
Apellido: <input type="text" name="apellidoCliente" value="<%= cliente.getApellido() %>" disabled><br/>
Dirección: <input type="text" name="direccionCliente" value="<%= cliente.getDireccion() %>" disabled><br/>
Correo: <input type="text" name="correoCliente" value="<%= cliente.getCorreo() %>" disabled><br/>
<% } else { %>
Nombre: <input type="text" name="nombreCliente" disabled><br/>
Apellido: <input type="text" name="apellidoCliente" disabled><br/>
Dirección: <input type="text" name="direccionCliente" disabled><br/>
Correo: <input type="text" name="correoCliente" disabled><br/>
<% } %>
<form id="productoForm" action="fetchData" method="get">
    <input type="hidden" name="tipo" value="producto"/>
    Producto ID: <input type="text" name="productoId" value="<%= request.getParameter("productoId") != null ? request.getParameter("productoId") : "" %>" />
    <button type="button" onclick="fetchData('producto')">Buscar Producto</button>
</form>
<h3>Datos del Producto</h3>
<% if (request.getAttribute("producto") != null) {
    Producto producto = (Producto) request.getAttribute("producto");
%>
Nombre: <input type="text" name="nombreProducto" value="<%= producto.getNombre() %>" disabled><br/>
Marca: <input type="text" name="marcaProducto" value="<%= producto.getMarca() %>" disabled><br/>
Precio: <input type="text" name="precioProducto" value="<%= producto.getPrecio() %>" disabled><br/>
Garantía: <input type="text" name="garantiaProducto" value="<%= producto.getGarantia() %>" disabled><br/>
Stock: <input type="text" name="stockProducto" value="<%= producto.getStock() %>" disabled><br/>
<% } else { %>
Nombre: <input type="text" name="nombreProducto" disabled><br/>
Marca: <input type="text" name="marcaProducto" disabled><br/>
Precio: <input type="text" name="precioProducto" disabled><br/>
Garantía: <input type="text" name="garantiaProducto" disabled><br/>
Stock: <input type="text" name="stockProducto" disabled><br/>
<% } %>

<%
    if (request.getAttribute("cliente") != null) {
        Cliente cliente = (Cliente) request.getAttribute("cliente");
        if (cliente.getUsuario() != null) {
            System.out.println("Cliente: " + cliente.getUsuario().getNombre());
        } else {
            System.out.println("Cliente encontrado, pero el objeto Usuario es null.");
        }
    } else if (request.getAttribute("producto") != null) {
        Producto producto = (Producto) request.getAttribute("producto");
        System.out.println("Producto: " + producto.getNombre());
    }
%>


</body>
</html>