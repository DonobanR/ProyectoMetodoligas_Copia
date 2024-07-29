<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulario Agregar Cliente</title>
    <script>
        function validateCedula() {
            const input = document.getElementById('cedula');
            const numeroCedula = input.value;
            console.log("Número de cédula en validateCedula: [" + numeroCedula + "]");

            const errorElement = document.getElementById('errorCedula');
            const submitButton = document.getElementById('submitButton');

            if (numeroCedula.length === 10) {
                // Codificar el valor de la cédula
                const encodedCedula = encodeURIComponent(numeroCedula);
                console.log("Número de cédula codificado: " + encodedCedula);

                // Construir la URL para la solicitud POST
                const url = 'verificarCedula';

                // Enviar la solicitud POST
                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'numero_cedula=' + encodedCedula
                })
                    .then(response => response.json())
                    .then(data => {
                        console.log("Respuesta del servidor: ", data);
                        console.log("Cédula válida: " + data.valid);
                        console.log("Cédula existe: " + data.exists);
                        if (data.valid) {
                            if (data.exists) {
                                errorElement.innerText = 'La cédula ya existe en la base de datos.';
                                errorElement.style.color = 'red';
                                submitButton.disabled = true; // Deshabilitar el botón si la cédula existe
                            } else {
                                errorElement.innerText = 'Cédula válida.';
                                errorElement.style.color = 'green';
                                submitButton.disabled = false; // Habilitar el botón si la cédula es válida y no existe
                            }
                        } else {
                            errorElement.innerText = 'Cédula inválida.';
                            errorElement.style.color = 'red';
                            submitButton.disabled = true; // Deshabilitar el botón si la cédula es inválida
                        }
                    })
                    .catch(error => {
                        console.error('Error en la validación:', error);
                    });
            } else {
                errorElement.innerText = 'La cédula debe tener exactamente 10 dígitos.';
                errorElement.style.color = 'red';
                submitButton.disabled = true; // Deshabilitar el botón si la cédula no tiene 10 dígitos
            }
        }

        function validateEmail(email) {
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailPattern.test(email);
        }

        function validateNumberInput(input) {
            const regex = /[^0-9]/g;
            input.value = input.value.replace(regex, '');
        }

        function validateField() {
            const nombre = document.getElementById('nombre');
            const apellido = document.getElementById('apellido');
            const direccion = document.getElementById('direccion');
            const correo = document.getElementById('correo');
            const errorElement = document.getElementById('errorForm');
            let isValid = true;

            // Validar campo de nombre
            if (nombre.value.trim().length === 0 || /[0-9]/.test(nombre.value)) {
                nombre.style.borderColor = 'red';
                isValid = false;
            } else {
                nombre.style.borderColor = '';
            }

            // Validar campo de apellido
            if (apellido.value.trim().length === 0 || /[0-9]/.test(apellido.value)) {
                apellido.style.borderColor = 'red';
                isValid = false;
            } else {
                apellido.style.borderColor = '';
            }

            // Validar campo de dirección
            if (direccion.value.trim().length === 0) {
                direccion.style.borderColor = 'red';
                isValid = false;
            } else {
                direccion.style.borderColor = '';
            }

            // Validar campo de correo
            if (!validateEmail(correo.value)) {
                correo.style.borderColor = 'red';
                isValid = false;
            } else {
                correo.style.borderColor = '';
            }

            if (!isValid) {
                errorElement.innerText = 'Por favor, corrija los errores en el formulario.';
                errorElement.style.color = 'red';
                return false;
            }

            errorElement.innerText = '';
            return true;
        }

        function initValidation() {
            const fields = ['nombre', 'apellido', 'direccion', 'correo', 'cedula'];

            fields.forEach(fieldId => {
                const field = document.getElementById(fieldId);
                field.addEventListener('input', validateField);
            });

            // Deshabilitar el botón de envío inicialmente
            const submitButton = document.getElementById('submitButton');
            submitButton.disabled = true;

            // Agregar el evento de validación de cédula
            const cedulaField = document.getElementById('cedula');
            cedulaField.addEventListener('input', validateCedula);
        }

        document.addEventListener('DOMContentLoaded', initValidation);
    </script>
</head>
<body>
<h1>Formulario para Agregar Cliente</h1>
<form id="formAgregarCliente" action="agregarCliente" method="post" onsubmit="return validateField()">
    <label for="cedula">Número de Cédula:</label>
    <input type="text" id="cedula" name="numero_cedula" oninput="validateNumberInput(this)" maxlength="10" required />
    <span id="errorCedula"></span>
    <br><br>

    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required />
    <br><br>

    <label for="apellido">Apellido:</label>
    <input type="text" id="apellido" name="apellido" required />
    <br><br>

    <label for="direccion">Dirección:</label>
    <input type="text" id="direccion" name="direccion" required />
    <br><br>

    <label for="correo">Correo:</label>
    <input type="email" id="correo" name="correo" required />
    <br><br>

    <button type="submit" id="submitButton">Agregar Cliente</button>
    <button type="button" onclick="window.location.href='gestionCliente.jsp'">Regresar a Gestión de Clientes</button>
    <span id="errorForm"></span>
</form>
</body>
</html>
