<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Formulario para Agregar Producto</title>
</head>
<body>
<h1>Formulario para Agregar Producto</h1>
<form id="agregarProductoForm" action="agregarProducto" method="post" onsubmit="return validarFormulario()">
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required><br>
    <label for="precio">Precio:</label>
    <input type="number" id="precio" name="precio" step="0.01" required><br>
    <label for="marca">Marca:</label>
    <input type="text" id="marca" name="marca" required><br>
    <label for="garantia">Garantía:</label>
    <select id="garantia" name="garantia" required>
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

<script>
    function validarFormulario() {
        var nombre = document.getElementById('nombre').value;
        var precio = document.getElementById('precio').value;
        var marca = document.getElementById('marca').value;
        var garantia = document.getElementById('garantia').value;
        var stock = document.getElementById('stock').value;

        if (nombre === '' || precio === '' || marca === '' || garantia === '' || stock === '') {
            alert('Por favor, llene todos los campos.');
            return false;
        }

        return true;
    }
</script>
</body>
</html>
