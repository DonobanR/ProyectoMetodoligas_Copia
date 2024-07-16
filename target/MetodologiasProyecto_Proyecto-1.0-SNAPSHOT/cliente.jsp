<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Buscar Cliente y Producto</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#buscarClienteForm').submit(function (event) {
                event.preventDefault(); // Prevenir el envío del formulario
                const numeroCedula = $('#numeroCedula').val();

                $.ajax({
                    url: 'obtenerCliente',
                    method: 'GET',
                    data: { numeroCedula: numeroCedula },
                    success: function (response) {
                        $('#resultadoCliente').html(response);
                    },
                    error: function () {
                        mostrarError('Error al obtener los datos del cliente.');
                    }
                });
            });

            $('#buscarProductoForm').submit(function (event) {
                event.preventDefault(); // Prevenir el envío del formulario
                const idProducto = $('#idProducto').val();
                const cantidad = $('#cantidad').val();

                $.ajax({
                    url: 'obtenerProducto',
                    method: 'GET',
                    data: { idProducto: idProducto },
                    success: function (response) {
                        agregarProducto(response, cantidad);
                    },
                    error: function () {
                        mostrarError('Error al obtener los datos del producto.');
                    }
                });
            });

            function agregarProducto(productoHtml, cantidad) {
                // Parsear el HTML recibido como cadena para manipularlo como objeto jQuery
                const $productoHtml = $(productoHtml);

                // Buscar si el producto ya está en la tabla
                const $productoExistente = $('#tablaProductos tbody').find('tr[data-id="' + $productoHtml.data('id') + '"]');

                if ($productoExistente.length > 0) {
                    // Si el producto ya existe, actualizar la cantidad y el total
                    const cantidadExistente = parseInt($productoExistente.find('.cantidad').text());
                    const nuevaCantidad = cantidadExistente + parseInt(cantidad);
                    $productoExistente.find('.cantidad').text(nuevaCantidad);

                    // Calcular y actualizar el total
                    const precioUnitario = parseFloat($productoExistente.find('.precio').text());
                    const nuevoTotal = precioUnitario * nuevaCantidad;
                    $productoExistente.find('.total').text(nuevoTotal.toFixed(2));
                } else {
                    // Si el producto no existe, agregar una nueva fila
                    $productoHtml.find('.cantidad').text(cantidad);
                    const precioUnitario = parseFloat($productoHtml.find('.precio').text());
                    const total = precioUnitario * parseInt(cantidad);
                    $productoHtml.find('.total').text(total.toFixed(2));

                    $('#tablaProductos tbody').append($productoHtml);
                }

                // Calcular el total general
                calcularTotalGeneral();

                // Limpiar el mensaje de error si lo hay
                limpiarError();
            }

            function calcularTotalGeneral() {
                let totalGeneral = 0;
                $('#tablaProductos tbody tr').each(function () {
                    const totalProducto = parseFloat($(this).find('.total').text());
                    totalGeneral += totalProducto;
                });

                $('#totalGeneral').text(totalGeneral.toFixed(2));
            }

            function mostrarError(mensaje) {
                $('#mensajeError').html('<p style="color: red;">' + mensaje + '</p>');
            }

            function limpiarError() {
                $('#mensajeError').empty();
            }

            function mostrarNotificacion(mensaje) {
                $('#notificacion').html('<p>' + mensaje + '</p>').fadeIn().delay(3000).fadeOut();
            }
        });
    </script>

    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">

</head>
<body class="bg-gray-200 p-4">

<h1 class="text-2xl font-bold mb-4">Buscar Cliente</h1>
<form id="buscarClienteForm" class="mb-4">
    <label for="numeroCedula" class="mr-2">Número de Cédula:</label>
    <input type="text" id="numeroCedula" name="numeroCedula" class="border rounded px-2 py-1">
    <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-4 rounded ml-2">Buscar Cliente</button>
</form>

<div id="resultadoCliente" class="mb-4"></div>

<h1 class="text-2xl font-bold mb-4">Buscar Producto</h1>
<form id="buscarProductoForm" class="mb-4">
    <label for="idProducto" class="mr-2">ID del Producto:</label>
    <input type="text" id="idProducto" name="idProducto" class="border rounded px-2 py-1">
    <label for="cantidad" class="mr-2">Cantidad:</label>
    <input type="number" id="cantidad" name="cantidad" min="1" value="1" class="border rounded px-2 py-1 w-20">
    <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-4 rounded ml-2">Agregar Producto</button>
</form>

<div id="mensajeError" class="mb-4"></div>
<div id="notificacion" style="display: none;" class="mb-4"></div>

<div id="resultadoProducto" class="mb-4">
    <table id="tablaProductos" class="table-auto border-collapse border w-full">
        <thead>
        <tr class="bg-gray-200">
            <th class="border px-4 py-2 text-center">ID</th>
            <th class="border px-4 py-2 text-center">Nombre</th>
            <th class="border px-4 py-2 text-center">Precio Unitario</th>
            <th class="border px-4 py-2 text-center">Cantidad</th>
            <th class="border px-4 py-2 text-center">Total</th>
            <th class="border px-4 py-2 text-center">Acciones</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="4" class="border px-4 py-2 text-center"><strong>Total General</strong></td>
            <td id="totalGeneral" class="border px-4 py-2 text-center">0.00</td>
            <td class="border px-4 py-2 text-center"></td>
        </tr>
        </tfoot>
    </table>
</div>

<script>
    function eliminarFila(button) {
        $(button).closest('tr').remove();
        calcularTotalGeneral();
        mostrarNotificacion('Producto eliminado correctamente.');
    }

    function calcularTotalGeneral() {
        let totalGeneral = 0;
        $('#tablaProductos tbody tr').each(function () {
            const totalProducto = parseFloat($(this).find('.total').text());
            totalGeneral += totalProducto;
        });

        $('#totalGeneral').text(totalGeneral.toFixed(2));
    }
</script>

</body>
</html>