<%@ page import="dao.ClienteDAO" %>
<%@ page import="entity.Cliente" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario Actualizar Cliente</title>
    <style>
        .error-message {
            color: red;
            font-size: 0.9em;
        }
        .input-error {
            border: 1px solid red;
        }
        .hidden {
            display: none;
        }
    </style>
    <script>
        function toggleEditMode(editing) {
            document.getElementById('nombre').disabled = !editing;
            document.getElementById('apellido').disabled = !editing;
            document.getElementById('direccion').disabled = !editing;
            document.getElementById('correo').disabled = !editing;
            document.getElementById('editButton').classList.toggle('hidden', editing);
            document.getElementById('cancelButton').classList.toggle('hidden', !editing);
            document.getElementById('submitButton').disabled = !editing;
        }

        function validateForm(event) {
            var nombre = document.getElementById('nombre').value.trim();
            var apellido = document.getElementById('apellido').value.trim();
            var direccion = document.getElementById('direccion').value.trim();
            var correo = document.getElementById('correo').value.trim();
            var errorMessage = '';

            if (!nombre || !apellido || !direccion || !correo) {
                errorMessage += 'Todos los campos son obligatorios.\n';
            }

            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (correo && !emailPattern.test(correo)) {
                errorMessage += 'El correo electrónico no es válido.\n';
            }

            if (errorMessage) {
                alert(errorMessage);
                event.preventDefault();
            }
        }
    </script>
</head>
<body>
<h2>Actualizar Cliente</h2>
<%
    String numeroCedula = request.getParameter("numero_cedula");
    ClienteDAO clienteDAO = new ClienteDAO();
    Cliente cliente = clienteDAO.obtenerClientePorCedula(Integer.parseInt(numeroCedula));
%>
<form id="formActualizarCliente" method="post" action="actualizarCliente" onsubmit="validateForm(event)">
    <input type="hidden" name="numero_cedula" value="<%= cliente.getId() %>">

    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" value="<%= cliente.getNombre() %>" disabled>
    <br>

    <label for="apellido">Apellido:</label>
    <input type="text" id="apellido" name="apellido" value="<%= cliente.getApellido() %>" disabled>
    <br>

    <label for="direccion">Dirección:</label>
    <input type="text" id="direccion" name="direccion" value="<%= cliente.getDireccion() %>" disabled>
    <br>

    <label for="correo">Correo:</label>
    <input type="email" id="correo" name="correo" value="<%= cliente.getCorreo() %>" disabled>
    <br>

    <button type="button" id="editButton" onclick="toggleEditMode(true)">Editar</button>
    <button type="button" id="cancelButton" class="hidden" onclick="toggleEditMode(false)">Cancelar</button>
    <button type="submit" id="submitButton" class="hidden">Actualizar Cliente</button>
</form>

<button type="button" onclick="window.location.href='gestionCliente.jsp'">Volver</button>
</body>
</html>
