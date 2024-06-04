<%@ page import="dao.ProductoDAO" %>
<%@ page import="entity.Producto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Actualizar Producto</title>
</head>
<body>

<%
    String mensaje = request.getParameter("mensaje");
    String idParam = request.getParameter("id");
    int id = Integer.parseInt(idParam);
    ProductoDAO productoDAO = new ProductoDAO();
    Producto producto = productoDAO.obtenerProductoPorId(id);
%>
<% if ("actualizacionExitosa".equals(mensaje)) { %>
<div class="alert alert-success">Actualización Exitosa</div>
<% } else if ("errorActualizacion".equals(mensaje)) { %>
<div class="alert alert-danger">Error en la Actualización</div>
<% } %>

<h1>Actualizar Producto</h1>
<form id="actualizarProductoForm" action="actualizarProducto" method="post">
    <label for="id">ID:</label>
    <input type="number" id="id" name="id" value="<%= producto.getId() %>" readonly required><br>
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" value="<%= producto.getNombreProducto() %>" required><br>
    <label for="precio">Precio:</label>
    <input type="number" id="precio" name="precio" step="0.01" value="<%= producto.getPrecio() %>" required><br>
    <label for="marca">Marca:</label>
    <input type="text" id="marca" name="marca" value="<%= producto.getMarca() %>" required><br>
    <label for="garantia">Garantía:</label>
    <select id="garantia" name="garantia" value="<%= producto.getGarantia() %>">
        <option value="1">1 año</option>
        <option value="2">2 años</option>
        <option value="3">3 años</option>
        <option value="4">4 años</option>
        <option value="5">5 años</option>
    </select><br>
    <label for="stock">Stock:</label>
    <input type="number" id="stock" name="stock" value="<%= producto.getStock() %>" required><br>
    <button type="submit">Actualizar</button>
</form>

</body>
</html>
