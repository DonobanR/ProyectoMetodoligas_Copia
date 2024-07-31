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
                if ($('#totalGeneral').text() === '0.00') {
                    mostrarError('No hay productos en la tabla.');
                    return;
                }

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
                $('#mensajeError').text(mensaje).show();
            }

            function limpiarError() {
                $('#mensajeError').empty().hide();
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

            $('#guardarVenta').click(function () {
                const mensajeError = validarDatos();
                if (mensajeError) {
                    mostrarError(mensajeError);
                    return; // No continuar si los datos no son válidos
                }

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
                        $('#totalGeneral').text('0.00');
                        $('#mensajeError').hide(); // Ocultar mensaje de error en caso de éxito
                    },
                    error: function () {
                        mostrarError('Error al guardar la venta.');
                    }
                });
            });

            // Nueva lógica para mostrar notificación de pago exitoso y desactivar botones
            $(document).on('confirmarPago', function() {
                $('#guardarVenta').prop('disabled', false);
                $('#mensajePago').text('Pago confirmado exitosamente.');
                $('#notificacionPago').show(); // Mostrar la notificación
                $('#efectivoBtn').prop('disabled', true);
                $('#tarjetaBtn').prop('disabled', true);
            });

        });

        function eliminarFila(button) {
            $(button).closest('tr').remove();
            calcularTotalGeneral();
            mostrarNotificacion('Producto eliminado correctamente.');
        }

        function validarDatos() {
            const clienteId = $('#numeroCedula').val();
            const productos = $('#tablaProductos tbody tr').length;

            if (!clienteId) {
                return 'El cliente debe ser seleccionado.';
            }

            if (productos === 0) {
                return 'Debe agregar al menos un producto a la venta.';
            }

            return null;
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
        <label for="idProducto" class="form-label">ID de Producto:</label>
        <input type="text" id="idProducto" name="idProducto" class="form-control">
    </div>
    <div class="mb-3">
        <label for="cantidad" class="form-label">Cantidad:</label>
        <input type="number" id="cantidad" name="cantidad" class="form-control">
    </div>
    <button type="submit" class="btn btn-primary">Buscar Producto</button>
</form>

<h2 class="mb-4">Productos</h2>
<div id="notificacion" style="display: none; color: green;"></div>
<table class="table table-bordered table-custom" id="tablaProductos">
    <thead>
    <tr>
        <th>Nombre</th>
        <th>Marca</th>
        <th>Precio</th>
        <th>Cantidad</th>
        <th>Total</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<h2 class="mt-4">Total: <span id="totalGeneral">0.00</span></h2>
<div id="mensajeError" class="alert alert-danger" style="display: none;"></div>

<div class="d-flex gap-2 mt-4">
    <button type="button" class="btn btn-efectivo btn-custom metodoPagoBtn" data-metodo="efectivo" id="efectivoBtn">Efectivo</button>
    <button type="button" class="btn btn-tarjeta btn-custom metodoPagoBtn" data-metodo="tarjeta" id="tarjetaBtn">Tarjeta</button>
</div>

<!-- Contenedor para el modal -->
<div id="modalContainer"></div>

<button type="button" id="guardarVenta" class="btn btn-success mt-4">Guardar Venta</button>
<div id="notificacionPago" style="display: none;">
    <p id="mensajePago" style="color: green;"></p>
</div>

</body>
</html>
