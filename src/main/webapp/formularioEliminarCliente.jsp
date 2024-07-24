<%@ page import="entity.Cliente" %>
<%@ page import="dao.ClienteDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Eliminar Cliente</title>
</head>
<body>

<%
    String mensaje = request.getParameter("mensaje");
    String numeroCedulaStr = request.getParameter("numero_cedula");
    Cliente cliente = null;

    if (numeroCedulaStr != null && !numeroCedulaStr.isEmpty()) {
        try {
            int numeroCedula = Integer.parseInt(numeroCedulaStr);
            ClienteDAO clienteDAO = new ClienteDAO();
            cliente = clienteDAO.obtenerClientePorCedula(numeroCedula);
        } catch (NumberFormatException e) {
            mensaje = "errorNumeroCedula";
        }
    } else {
        mensaje = "numeroCedulaFaltante";
    }
%>

<% if ("eliminacionExitosa".equals(mensaje)) { %>
<div class="alert alert-success">Eliminación Exitosa</div>
<% } else if ("errorEliminacion".equals(mensaje)) { %>
<div class="alert alert-danger">Error en la Eliminación</div>
<% } else if ("errorNumeroCedula".equals(mensaje)) { %>
<div class="alert alert-danger">Número de cédula inválido</div>
<% } else if ("numeroCedulaFaltante".equals(mensaje)) { %>
<div class="alert alert-danger">Número de cédula no proporcionado</div>
<% } %>

<h1>Eliminar Cliente</h1>
<% if (cliente != null) { %>
<p>¿Está seguro de que desea eliminar el siguiente cliente?</p>
<p>Cédula de Identidad: <%= cliente.getId() %></p>
<p>Nombre: <%= cliente.getNombre() %></p>
<p>Apellido: <%= cliente.getApellido() %></p>
<p>Dirección: <%= cliente.getDireccion() %></p>
<p>Correo: <%= cliente.getCorreo() %></p>

<form id="eliminarClienteForm" action="eliminarCliente" method="post">
    <input type="hidden" name="numero_cedula" value="<%= cliente.getId() %>">
    <button type="submit">Eliminar</button>
    <button type="button" onclick="window.location.href='gestionCliente.jsp'">Cancelar</button>
</form>

<% } else { %>
<p>Cliente no encontrado.</p>
<button type="button" onclick="window.location.href='gestionCliente.jsp'">Volver</button>
<% } %>

</body>
</html>
