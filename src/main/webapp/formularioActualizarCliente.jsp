<%--
  Created by IntelliJ IDEA.
  User: USUARIO
  Date: 8/7/2024
  Time: 0:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="dao.ClienteDAO" %>
<%@ page import="entity.Cliente" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actualizar Cliente</title>
</head>
<body>

<%
    String mensaje = request.getParameter("mensaje");
    String numeroCedulaStr = request.getParameter("id");
    int numeroCedula = Integer.parseInt(numeroCedulaStr);
    ClienteDAO clienteDAO = new ClienteDAO();
    Cliente cliente = clienteDAO.obtenerClientePorCedula(numeroCedula);
%>
<% if ("actualizacionExitosa".equals(mensaje)) { %>
<div class="alert alert-success">Actualización Exitosa</div>
<% } else if ("errorActualizacion".equals(mensaje)) { %>
<div class="alert alert-danger">Error en la Actualización</div>
<% } %>

<h1>Editar Cliente</h1>

<% if (cliente != null) { %>
<form id="actualizarClienteForm" action="actualizarCliente" method="post">
    <input type="hidden" name="numero_cedula" value="<%= cliente.getId() %>">
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" value="<%= cliente.getNombre() %>" required>
    <label for="apellido">Apellido:</label>
    <input type="text" id="apellido" name="apellido" value="<%= cliente.getApellido() %>" required>
    <label for="direccion">Dirección:</label>
    <input type="text" id="direccion" name="direccion" value="<%= cliente.getDireccion() %>">
    <label for="correo">Correo:</label>
    <input type="email" id="correo" name="correo" value="<%= cliente.getCorreo() %>">
    <button type="submit">Actualizar Cliente</button>
    <button type="button" onclick="window.location.href='gestionCliente.jsp'">Cancelar</button>
</form>
<% } else { %>
<p>Descuento no encontrado.</p>
<button type="button" onclick="window.location.href='gestionCliente.jsp'">Volver</button>
<% } %>

</body>
</html>