<%--
  Created by IntelliJ IDEA.
  User: USUARIO
  Date: 3/5/2024
  Time: 17:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Editar Descuento</title>
</head>
<body>
<h1>Editar Descuento</h1>
<form action="DescuentoServlet" method="POST">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="idDescuento" value="${descuento.idDescuento}">
    <p>Código: <input type="text" name="codigo" value="${descuento.codigo}"></p>
    <p>Nombre: <input type="text" name="nombre" value="${descuento.nombre}"></p>
    <p>Porcentaje de Descuento: <input type="text" name="porcentajeDescuento" value="${descuento.porcentajeDescuento}"></p>
    <p>Stock: <input type="number" name="stock" value="${descuento.stock}"></p>
    <input type="submit" value="Actualizar Descuento">
</form>
</body>
</html>
