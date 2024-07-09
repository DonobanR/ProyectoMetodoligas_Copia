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
    String numeroCedulaStr = request.getParameter("numero_cedula");
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
<form action="actualizarCliente" method="post">
    <input type="hidden" name="numero_cedula" value="<%= cliente.getId() %>">
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" value="<%= cliente.getNombre() %>" required>
    <br>
    <label for="apellido">Apellido:</label>
    <input type="text" id="apellido" name="apellido" value="<%= cliente.getApellido() %>" required>
    <br>
    <label for="direccion">Dirección:</label>
    <input type="text" id="direccion" name="direccion" value="<%= cliente.getDireccion() %>">
    <br>
    <label for="correo">Correo:</label>
    <input type="email" id="correo" name="correo" value="<%= cliente.getCorreo() %>">
    <br>
    <button type="submit">Actualizar Cliente</button>
</form>
<% } else { %>
<p>Cliente no encontrado.</p>
<button type="button" onclick="window.location.href='gestionCliente.jsp'">Volver</button>
<% } %>

</body>
</html>
