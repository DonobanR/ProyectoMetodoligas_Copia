<%--
  Created by IntelliJ IDEA.
  User: USUARIO
  Date: 8/7/2024
  Time: 0:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="dao.ClienteDAO" %>
<%@ page import="entity.Cliente" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Eliminar Cliente</title>
</head>
<body>

<%
    String mensaje = request.getParameter("mensaje");
    String numeroCedulaStr = request.getParameter("numero_cedula");
    int numeroCedula = Integer.parseInt(numeroCedulaStr);
    ClienteDAO clienteDAO = new ClienteDAO();
    Cliente cliente = clienteDAO.obtenerClientePorCedula(numeroCedula);
%>
<% if ("eliminacionExitosa".equals(mensaje)) { %>
<div class="alert alert-success">Eliminación Exitosa</div>
<% } else if ("errorEliminacion".equals(mensaje)) { %>
<div class="alert alert-danger">Error en la Eliminación</div>
<% } %>

<h1>Eliminar Cliente</h1>
<% if (cliente != null) { %>
<p>¿Estás seguro de que deseas eliminar al siguiente cliente?</p>
<p>Cédula: <%= cliente.getId() %></p>
<p>Nombre: <%= cliente.getNombre() %></p>
<p>Apellido: <%= cliente.getApellido() %></p>
<p>Dirección: <%= cliente.getDireccion() %></p>
<p>Correo: <%= cliente.getCorreo() %></p>
<form action="eliminarCliente" method="post">
    <input type="hidden" name="numero_cedula" value="<%= cliente.getId() %>">
    <button type="submit">Eliminar Cliente</button>
</form>
<% } else { %>
<p>Descuento no encontrado.</p>
<button type="button" onclick="window.location.href='gestionCliente.jsp'">Volver</button>
<% } %>

</body>
</html>
