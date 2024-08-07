<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<!-- Modal para Confirmar Pago -->
<div class="modal fade" id="confirmarPagoModal" tabindex="-1" aria-labelledby="confirmarPagoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarPagoModalLabel">Confirmar Pago en Efectivo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Monto Total: <span id="montoTotalModal"><%= request.getParameter("montoTotal") %></span></p>
                <div class="mb-3">
                    <label for="montoRecibido" class="form-label">Monto Recibido:</label>
                    <input type="number" id="montoRecibido" class="form-control" placeholder="Ingrese monto recibido" step="0.01">
                </div>
                <p>Vuelto: <span id="vuelto">0.00</span></p>
                <button id="confirmarPagoBtn" class="btn btn-primary">Confirmar</button>
                <button id="cancelarPagoBtn" class="btn btn-secondary">Cancelar</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        function actualizarEstadoBotonConfirmar() {
            const montoRecibido = parseFloat($('#montoRecibido').val()) || 0;
            const montoTotal = parseFloat($('#montoTotalModal').text()) || 0;

            // Habilitar o deshabilitar el botón Confirmar
            $('#confirmarPagoBtn').prop('disabled', montoRecibido < montoTotal);
        }

        $('#montoRecibido').on('input', function () {
            const montoRecibido = parseFloat($(this).val()) || 0;
            const montoTotal = parseFloat($('#montoTotalModal').text()) || 0;
            const vuelto = montoRecibido - montoTotal;

            $('#vuelto').text(vuelto.toFixed(2));

            // Actualizar el estado del botón Confirmar
            actualizarEstadoBotonConfirmar();
        });

        $('#confirmarPagoBtn').click(function () {
            console.log('Botón Confirmar presionado');
            const montoRecibido = parseFloat($('#montoRecibido').val()) || 0;
            const montoTotal = parseFloat($('#montoTotalModal').text()) || 0;

            if (montoRecibido >= montoTotal) {
                // Emitir el evento personalizado
                $(document).trigger('confirmarPago');
                // Cerrar el modal
                $('#confirmarPagoModal').modal('hide');
            } else {
                console.error('Monto recibido menor que el monto total.');
            }
        });

        $('#cancelarPagoBtn').click(function () {
            console.log('Botón Cancelar presionado');
            $('#confirmarPagoModal').modal('hide');
        });

        // Inicializar el estado del botón Confirmar cuando la página se carga
        actualizarEstadoBotonConfirmar();

        // Escuchar el evento confirmarPago
        $(document).on('confirmarPago', function() {
            console.log('Evento confirmarPago recibido');
        });
    });

</script>

</body>
</html>