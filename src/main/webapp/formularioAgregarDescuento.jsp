<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Descuentos</title>
</head>
<body>

<h2>Ingresar Detalles del Descuento</h2>
<form action="agregarDescuento" method="post">
    <label for="codigo">Código:</label>
    <input type="text" id="codigo" name="codigo" required><br>
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required><br>
    <label for="porcentajeDescuento">Descuento %:</label>
    <select id="porcentajeDescuento" name="porcentajeDescuento">
        <option value="10">10</option>
        <option value="20">20</option>
        <option value="35">35</option>
        <option value="40">40</option>
        <option value="50">50</option>
    </select><br>
    <label for="stock">Stock:</label>
    <input type="number" id="stock" name="stock" required><br>
    <button type="submit">Agregar</button>
</form>

<%
    String mensaje = (String) request.getAttribute("mensaje");
    if (mensaje != null) {
        PrintWriter writer = response.getWriter();
        writer.print("<p>" + mensaje + "</p>");
        Boolean agregarOtro = (Boolean) request.getAttribute("agregarOtro");
        if (agregarOtro != null && agregarOtro) {
%>
<p>¿Desea agregar otro descuento?</p>
<form action="agregarDescuento" method="post">
    <button type="submit">Sí</button>
</form>
<form action="" method="get">
    <button type="submit">No</button>
</form>
<%
        } else {
            // Redirigir a la página principal u otra página de tu elección
            response.sendRedirect("");
        }
    }
%>

</body>
</html>
