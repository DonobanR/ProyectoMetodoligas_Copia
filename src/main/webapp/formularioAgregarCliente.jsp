<%--
  Created by IntelliJ IDEA.
  User: Alexander Tibanta
  Date: 8/7/2024
  Time: 0:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Clientes</title>
</head>
<body>

<h2>Ingresar Detalles del Cliente</h2>
<form action="agregarCliente" method="post">
    <label for="numero_cedula">Cédula:</label>
    <input type="text" id="numero_cedula" name="numero_cedula" required>
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required>
    <label for="apellido">Apellido:</label>
    <input type="text" id="apellido" name="apellido" required>
    <label for="direccion">Dirección:</label>
    <input type="text" id="direccion" name="direccion">
    <label for="correo">Correo:</label>
    <input type="email" id="correo" name="correo">
    <button type="submit">Agregar Cliente 1111</button>
</form>

<br>
<a href="gestionClientes.jsp">Volver a la gestión de clientes</a>

</body>
</html>
