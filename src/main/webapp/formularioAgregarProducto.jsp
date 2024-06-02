<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Producto</title>
</head>
<body>
<h2>Ingresar Detalles del Producto</h2>
<form action="agregarProducto" method="post">
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required><br>
    <label for="precio">Precio:</label>
    <input type="number" id="precio" name="precio" step="0.01" required><br>
    <label for="marca">Marca:</label>
    <input type="text" id="marca" name="marca" required><br>
    <label for="garantia">Garantía:</label>
    <select id="garantia" name="garantia">
        <option value="1">1 año</option>
        <option value="2">2 años</option>
        <option value="3">3 años</option>
        <option value="4">4 años</option>
        <option value="5">5 años</option>
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
<p>¿Desea agregar otro producto?</p>
<form action="agregarProducto" method="get">
    <button type="submit">Sí</button>
</form>
<form action="index.jsp" method="get">
    <button type="submit">No</button>
</form>
<%
        } else {
            // Redirigir a la página principal u otra página de tu elección
            response.sendRedirect("index.jsp");
        }
    }
%>


</body>
</html>
