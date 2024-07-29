<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Buscar Cliente y Producto</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .btn-custom {
            font-weight: bold;
            border-radius: .375rem;
        }
        .btn-efectivo {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-efectivo:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .btn-tarjeta {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-tarjeta:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .table-custom th, .table-custom td {
            text-align: center;
            vertical-align: middle;
        }
    </style>
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

            $('.metodoPagoBtn').click(function () {
                const metodoSeleccionado = $(this).data('metodo');
                if (metodoSeleccionado === 'efectivo') {
                    const montoTotal = $('#totalGeneral').text();
                    $.ajax({
                        url: 'efectivo.jsp',
                        method: 'GET',
                        data: { montoTotal: montoTotal },
                        success: function (response) {
                            $('#modalContainer').html(response);
                            $('#confirmarPagoModal').modal('show'); // Mostrar el modal
                        },
                        error: function () {
                            mostrarError('Error al cargar el modal de pago.');
                        }
                    });
                } else if (metodoSeleccionado === 'tarjeta') {
                    // Agregar redirección o lógica para 'tarjeta' si es necesario
                }
            });

            function agregarProducto(productoHtml, cantidad) {
                const $productoHtml = $(productoHtml);
                const $productoExistente = $('#tablaProductos tbody').find('tr[data-id="' + $productoHtml.data('id') + '"]');

                if ($productoExistente.length > 0) {
                    const cantidadExistente = parseInt($productoExistente.find('.cantidad').text());
                    const nuevaCantidad = cantidadExistente + parseInt(cantidad);
                    $productoExistente.find('.cantidad').text(nuevaCantidad);

                    const precioUnitario = parseFloat($productoExistente.find('.precio').text());
                    const nuevoTotal = precioUnitario * nuevaCantidad;
                    $productoExistente.find('.total').text(nuevoTotal.toFixed(2));
                } else {
                    $productoHtml.find('.cantidad').text(cantidad);
                    const precioUnitario = parseFloat($productoHtml.find('.precio').text());
                    const total = precioUnitario * parseInt(cantidad);
                    $productoHtml.find('.total').text(total.toFixed(2));

                    $('#tablaProductos tbody').append($productoHtml);
                }

                calcularTotalGeneral();
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

            $('#guardarVenta').prop('disabled', true);

            $(document).on('change', '#confirmarPago', function() {
                if ($(this).is(':checked')) {
                    $('#guardarVenta').prop('disabled', false);
                } else {
                    $('#guardarVenta').prop('disabled', true);
                }
            });

            $(document).on('confirmarPago', function() {
                $('#guardarVenta').prop('disabled', false);
            });
        });
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
        $(document).ready(function () {
            $('#guardarVenta').click(function () {
                const cliente = {
                    id: $('#numeroCedula').val(),
                    // Añadir otros campos del cliente si es necesario
                };

                const productos = [];
                $('#tablaProductos tbody tr').each(function () {
                    const id = $(this).data('id');
                    const nombre = $(this).find('.nombre').text();
                    const precio = parseFloat($(this).find('.precio').text());
                    const cantidad = parseInt($(this).find('.cantidad').text());
                    productos.push({ id, nombre, precio, stock: cantidad });
                });

                $.ajax({
                    url: 'guardarVentaB',
                    method: 'POST',
                    data: {
                        cliente: JSON.stringify(cliente),
                        productos: JSON.stringify(productos)
                    },
                    xhrFields: {
                        responseType: 'blob'
                    },
                    success: function (response) {
                        const blob = new Blob([response], { type: 'application/pdf' });
                        const link = document.createElement('a');
                        link.href = window.URL.createObjectURL(blob);
                        link.download = 'factura.pdf';
                        link.click();
                        mostrarNotificacion('Venta guardada exitosamente.');
                        $('#tablaProductos tbody').empty();
                        $('#totalGeneral').text('1.00');
                    },
                    error: function () {
                        mostrarError('Error al guardar la venta.');
                    }
                });
            });
        });
    </script>
</head>
<body class="container p-4">

<h1 class="mb-4">Buscar Cliente</h1>
<form id="buscarClienteForm" class="mb-4">
    <div class="mb-3">
        <label for="numeroCedula" class="form-label">Número de Cédula:</label>
        <input type="text" id="numeroCedula" name="numeroCedula" class="form-control">
    </div>
    <button type="submit" class="btn btn-primary">Buscar Cliente</button>
</form>

<div id="resultadoCliente" class="mb-4"></div>

<h1 class="mb-4">Buscar Producto</h1>
<form id="buscarProductoForm" class="mb-4">
    <div class="mb-3">
        <label for="idProducto" class="form-label">ID del Producto:</label>
        <input type="text" id="idProducto" name="idProducto" class="form-control">
    </div>
    <div class="mb-3">
        <label for="cantidad" class="form-label">Cantidad:</label>
        <input type="number" id="cantidad" name="cantidad" min="1" value="1" class="form-control w-25">
    </div>
    <button type="submit" class="btn btn-primary">Agregar Producto</button>
</form>

<div id="mensajeError" class="mb-4"></div>
<div id="notificacion" class="mb-4" style="display: none;"></div>

<div id="resultadoProducto" class="mb-4">
    <table id="tablaProductos" class="table table-striped table-bordered table-custom">
        <thead>
        <tr class="table-secondary">
            <th>ID</th>
            <th>Nombre</th>
            <th>Precio Unitario</th>
            <th>Cantidad</th>
            <th>Total</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="4" class="table-primary"><strong>Total General</strong></td>
            <td id="totalGeneral" class="table-primary">0.00</td>
            <td></td>
        </tr>
        </tfoot>
    </table>
</div>

<!-- Botones para Métodos de Pago -->
<div class="mb-4">
    <button id="efectivoBtn" class="btn btn-custom btn-efectivo metodoPagoBtn" data-metodo="efectivo">Efectivo</button>
    <button id="tarjetaBtn" class="btn btn-custom btn-tarjeta metodoPagoBtn" data-metodo="tarjeta">Tarjeta</button>
</div>

<button id="guardarVenta" class="btn btn-secondary mt-4" disabled>Guardar Venta</button>

<!-- Contenedor para el modal -->
<div id="modalContainer"></div>

</body>
</html>
