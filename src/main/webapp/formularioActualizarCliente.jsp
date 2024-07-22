<%-- Código existente en gestionClientes.jsp --%>

<!-- Modal para agregar cliente -->
<div id="modalAgregarCliente" class="modal">
    <div class="modal-content">

        <span class="close">&times;</span>
        <h2>Ingresar Detalles del Cliente</h2>
        <form id="formAgregarCliente" method="post" action="actualizarCliente">
            <label for="numero_cedula">Cédula:</label>
            <input type="text" id="numero_cedula" name="numero_cedula" required>
            <span id="errorCedula" class="error-message">
                <% String error = (String) request.getAttribute("error"); %>
                <%= error != null ? error : "" %>
            </span>
            <br>

            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required>
            <br>

            <label for="apellido">Apellido:</label>
            <input type="text" id="apellido" name="apellido" required>
            <br>

            <label for="direccion">Dirección:</label>
            <input type="text" id="direccion" name="direccion">
            <br>

            <label for="correo">Correo:</label>
            <input type="email" id="correo" name="correo">
            <br>

            <button type="submit">Agregar Cliente</button>
        </form>
    </div>
</div>

<script>
    // JavaScript para manejar el modal
    var modal = document.getElementById('modalAgregarCliente');
    var btn = document.getElementById('agregarClienteBtn');
    var span = document.getElementsByClassName('close')[0];

    btn.onclick = function() {
        modal.style.display = 'block';
    }

    span.onclick = function() {
        modal.style.display = 'none';
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }
</script>
