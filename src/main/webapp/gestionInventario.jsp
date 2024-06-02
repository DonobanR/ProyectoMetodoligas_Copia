<%@ page import="java.util.List" %>
<%@ page import="dao.ProductoDAO" %>
<%@ page import="entity.Producto" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gesti&oacute;n de Inventario</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<h1>Gestion de Inventario</h1>

<h2>Buscar Producto</h2>
<form id="searchForm">
    <label for="filtro">Filtrar por:</label>
    <select id="filtro" name="filtro">
        <option value="nombreProducto">Nombre</option>
        <option value="precio">Precio</option>
        <option value="marca">Marca</option>
        <option value="garantia">Garantía</option>
        <option value="stock">Stock</option>
    </select>
    <label for="terminoBusqueda">Termino de busqueda:</label>
    <input type="text" id="terminoBusqueda" name="terminoBusqueda">
    <button type="submit">Buscar</button>
</form>

<h2>Inventario Actual</h2>
<table id="productos">
    <tr>
        <th>Nombre</th>
        <th>Precio</th>
        <th>Marca</th>
        <th>Garantia</th>
        <th>Stock</th>
    </tr>
    <%
        ProductoDAO productoDAO = new ProductoDAO();
        List<Producto> productos = productoDAO.obtenerProductos();

        for (Producto producto : productos) {
    %>
    <tr>
        <td><%= producto.getNombreProducto() %></td>
        <td><%= producto.getPrecio() %></td>
        <td><%= producto.getMarca() %></td>
        <td><%= producto.getGarantia() %></td>
        <td><%= producto.getStock() %></td>
    </tr>
    <% } %>
</table>

<button onclick="mostrarFormulario()">Agregar Producto</button>

<script>
    function mostrarFormulario() {
        window.open('formularioAgregarProducto.jsp', 'Agregar Producto', 'width=400,height=400');
    }
    document.getElementById('searchForm').addEventListener('submit', function(event) {
        event.preventDefault(); // Evita que se recargue la página al enviar el formulario
        var filtro = document.getElementById('filtro').value;
        var terminoBusqueda = document.getElementById('terminoBusqueda').value;
        var url = 'buscarProducto?filtro=' + filtro + '&terminoBusqueda=' + terminoBusqueda;
        fetch(url)
            .then(response => response.json())
            .then(data => {
                // Limpiar la tabla actual
                var table = document.getElementById('productos');
                table.innerHTML = '';
                // Agregar los encabezados de columna con estilo en negrita
                var headerRow = table.insertRow();
                var headers = ['Nombre', 'Precio', 'Marca', 'Garantia', 'Stock'];
                headers.forEach(headerText => {
                    var headerCell = document.createElement('th');
                    headerCell.textContent = headerText;
                    headerCell.style.fontWeight = 'bold'; // Aplica negrita
                    headerRow.appendChild(headerCell);
                });
                // Agregar los nuevos productos a la tabla
                data.forEach(producto => {
                    var row = table.insertRow();
                    row.insertCell(0).textContent = producto.nombreProducto;
                    row.insertCell(1).textContent = producto.precio;
                    row.insertCell(2).textContent = producto.marca;
                    row.insertCell(3).textContent = producto.garantia;
                    row.insertCell(4).textContent = producto.stock;
                });
            });
    });
</script>

</body>
</html>