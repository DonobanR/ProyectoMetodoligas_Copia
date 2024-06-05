<%@ page import="dao.DescuentoDAO" %>
<%@ page import="entity.Descuento" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Eliminar Descuento</title>
</head>
<body>

<%
    String mensaje = request.getParameter("mensaje");
    String idParam = request.getParameter("id");
    int id = Integer.parseInt(idParam);
    DescuentoDAO descuentoDAO = new DescuentoDAO();
    Descuento descuento = descuentoDAO.obtenerDescuentoPorId(id);
%>
<% if ("eliminacionExitosa".equals(mensaje)) { %>
<div class="alert alert-success">Eliminación Exitosa</div>
<% } else if ("errorEliminacion".equals(mensaje)) { %>
<div class="alert alert-danger">Error en la Eliminación</div>
<% } %>

<h1>Eliminar Descuento</h1>
<% if (descuento != null) { %>
<p>¿Está seguro de que desea eliminar el siguiente descuento?</p>
<p>ID: <%= descuento.getId() %></p>
<p>Código: <%= descuento.getCodigo() %></p>
<p>Nombre: <%= descuento.getNombre() %></p>
<p>Porcentaje Descuento: <%= descuento.getPorcentajeDescuento() %></p>
<p>Stock: <%= descuento.getStock() %></p>

<form id="eliminarDescuentoForm" action="eliminarDescuento" method="post">
    <input type="hidden" id="id" name="id" value="<%= descuento.getId() %>">
    <button type="submit">Eliminar</button>
    <button type="button" onclick="window.location.href='gestionDescuento.jsp'">Cancelar</button>
</form>
<% } else { %>
<p>Descuento no encontrado.</p>
<button type="button" onclick="window.location.href='gestionDescuento.jsp'">Volver</button>
<% } %>

</body>
</html>
