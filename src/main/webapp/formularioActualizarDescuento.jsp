<%@ page import="dao.DescuentoDAO" %>
<%@ page import="entity.Descuento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Actualizar Descuento</title>
</head>
<body>

<%
    String mensaje = request.getParameter("mensaje");
    String idParam = request.getParameter("id");
    int id = Integer.parseInt(idParam);
    DescuentoDAO descuentoDAO = new DescuentoDAO();
    Descuento descuento = descuentoDAO.obtenerDescuentoPorId(id);
%>
<% if ("actualizacionExitosa".equals(mensaje)) { %>
<div class="alert alert-success">Actualización Exitosa</div>
<% } else if ("errorActualizacion".equals(mensaje)) { %>
<div class="alert alert-danger">Error en la Actualización</div>
<% } %>

<h1>Actualizar Descuento</h1>

<% if (descuento != null) { %>
<form id="actualizarDescuentoForm" action="actualizarDescuento" method="post">
    <input type="hidden" id="id" name="id" value="<%= descuento.getId() %>">
    <label for="codigo">Código:</label>
    <input type="text" id="codigo" name="codigo" value="<%= descuento.getCodigo() %>" required><br>
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" value="<%= descuento.getNombre() %>" required><br>
    <label for="porcentajeDescuento">Porcentaje Descuento:</label>
    <input type="text" id="porcentajeDescuento" name="porcentajeDescuento" value="<%= descuento.getPorcentajeDescuento() %>" required><br>
    <label for="stock">Stock:</label>
    <input type="text" id="stock" name="stock" value="<%= descuento.getStock() %>" required><br>
    <button type="submit">Actualizar</button>
    <button type="button" onclick="window.location.href='gestionDescuento.jsp'">Cancelar</button>
</form>
<% } else { %>
<p>Descuento no encontrado.</p>
<button type="button" onclick="window.location.href='gestionDescuento.jsp'">Volver</button>
<% } %>

</body>
</html>
