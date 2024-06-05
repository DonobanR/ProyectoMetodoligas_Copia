<%@ page import="dao.ProductoDAO" %>
<%@ page import="entity.Producto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Eliminar Producto</title>
</head>
<body>

<%
    String mensaje = request.getParameter("mensaje");
    String idParam = request.getParameter("id");
    int id = Integer.parseInt(idParam);
    ProductoDAO productoDAO = new ProductoDAO();
    Producto producto = productoDAO.obtenerProductoPorId(id);
%>
<% if ("eliminacionExitosa".equals(mensaje)) { %>
<div class="alert alert-success">Eliminación Exitosa</div>
<% } else if ("errorEliminacion".equals(mensaje)) { %>
<div class="alert alert-danger">Error en la Eliminación</div>
<% } %>

<h1>Eliminar Producto</h1>
<% if (producto != null) { %>
<p>¿Está seguro de que desea eliminar el siguiente producto?</p>
<p>ID: <%= producto.getId() %></p>
<p>Nombre: <%= producto.getNombreProducto() %></p>
<p>Precio: <%= producto.getPrecio() %></p>
<p>Marca: <%= producto.getMarca() %></p>
<p>Garantía: <%= producto.getGarantia() %></p>
<p>Stock: <%= producto.getStock() %></p>

<form id="eliminarProductoForm" action="eliminarProducto" method="post">
    <input type="hidden" id="id" name="id" value="<%= producto.getId() %>">
    <button type="submit">Eliminar</button>
    <button type="button" onclick="window.location.href='gestionInventario.jsp'">Cancelar</button>
</form>
<% } else { %>
<p>Producto no encontrado.</p>
<button type="button" onclick="window.location.href='gestionInventario.jsp'">Volver</button>
<% } %>

</body>
</html>
