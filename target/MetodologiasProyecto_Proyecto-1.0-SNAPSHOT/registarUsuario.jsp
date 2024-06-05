<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrarse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Estilos para el mensaje de éxito */
        .notification {
            display: none; /* Oculto por defecto */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
            text-align: center;
        }
        .notification button {
            margin-top: 10px;
            padding: 10px;
            background-color: white;
            color: #4CAF50;
            border: none;
            cursor: pointer;
        }
        .notification button:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
<section class="bg-white">
    <div class="grid grid-cols-1 lg:grid-cols-2">
        <div class="flex items-center justify-center px-4 py-10 bg-white sm:px-6 lg:px-8 sm:py-16 lg:py-24">
            <div class="xl:w-full xl:max-w-sm 2xl:max-w-md xl:mx-auto">
                <h2 class="text-3xl font-bold leading-tight text-black sm:text-4xl">Registrate al Sistema</h2>
                <p class="mt-2 text-base text-gray-600">¿Ya tienes una cuenta? <a href="iniciarSesion.jsp" title="" class="font-medium text-blue-600 transition-all duration-200 hover:text-blue-700 hover:underline focus:text-blue-700">Iniciar Sesi&oacute;n</a></p>

                <form action="registro" method="POST" class="mt-8">
                    <div class="space-y-5">
                        <div>
                            <label for="nombre" class="text-base font-medium text-gray-900"> Primer Nombre </label>
                            <div class="mt-2.5">
                                <input
                                        type="text"
                                        name="nombre"
                                        id="nombre"
                                        placeholder="Ingrese su primer nombre"
                                        class="block w-full p-4 text-black placeholder-gray-500 transition-all duration-200 border border-gray-200 rounded-md bg-gray-50 focus:outline-none focus:border-blue-600 focus:bg-white caret-blue-600"
                                />
                            </div>
                        </div>

                        <div>
                            <label for="apellido" class="text-base font-medium text-gray-900"> Primer Apellido </label>
                            <div class="mt-2.5">
                                <input
                                        type="text"
                                        name="apellido"
                                        id="apellido"
                                        placeholder="Ingrese su primer apellido"
                                        class="block w-full p-4 text-black placeholder-gray-500 transition-all duration-200 border border-gray-200 rounded-md bg-gray-50 focus:outline-none focus:border-blue-600 focus:bg-white caret-blue-600"
                                />
                            </div>
                        </div>

                        <div>
                            <label for="numeroCedula" class="text-base font-medium text-gray-900"> Numero de C&eacute;dula </label>
                            <div class="mt-2.5">
                                <input
                                        type="number"
                                        name="numeroCedula"
                                        id="numeroCedula"
                                        placeholder="Ingrese su n&uacute;mero de c&eacute;dula"
                                        class="block w-full p-4 text-black placeholder-gray-500 transition-all duration-200 border border-gray-200 rounded-md bg-gray-50 focus:outline-none focus:border-blue-600 focus:bg-white caret-blue-600"
                                />
                            </div>
                        </div>

                        <div>
                            <label for="direccion" class="text-base font-medium text-gray-900"> Direcci&oacute;n </label>
                            <div class="mt-2.5">
                                <input
                                        type="text"
                                        name="direccion"
                                        id="direccion"
                                        placeholder="Ingrese su direcci&oacute;n de residencia"
                                        class="block w-full p-4 text-black placeholder-gray-500 transition-all duration-200 border border-gray-200 rounded-md bg-gray-50 focus:outline-none focus:border-blue-600 focus:bg-white caret-blue-600"
                                />
                            </div>
                        </div>

                        <div>
                            <label for="correo" class="text-base font-medium text-gray-900"> Correo Electr&oacute;nico </label>
                            <div class="mt-2.5">
                                <input
                                        type="email"
                                        name="correo"
                                        id="correo"
                                        placeholder="Ingrese su correo electrónico"
                                        class="block w-full p-4 text-black placeholder-gray-500 transition-all duration-200 border border-gray-200 rounded-md bg-gray-50 focus:outline-none focus:border-blue-600 focus:bg-white caret-blue-600"
                                />
                            </div>
                        </div>

                        <div>
                            <label for="usuario" class="text-base font-medium text-gray-900"> Usuario </label>
                            <div class="mt-2.5">
                                <input
                                        type="text"
                                        name="usuario"
                                        id="usuario"
                                        placeholder="Ingrese su nombre de usuario"
                                        class="block w-full p-4 text-black placeholder-gray-500 transition-all duration-200 border border-gray-200 rounded-md bg-gray-50 focus:outline-none focus:border-blue-600 focus:bg-white caret-blue-600"
                                />
                            </div>
                        </div>

                        <div>
                            <label for="contrasena" class="text-base font-medium text-gray-900"> Contraseña </label>
                            <div class="mt-2.5">
                                <input
                                        type="password"
                                        name="contrasena"
                                        id="contrasena"
                                        placeholder="Ingrese su contraseña"
                                        class="block w-full p-4 text-black placeholder-gray-500 transition-all duration-200 border border-gray-200 rounded-md bg-gray-50 focus:outline-none focus:border-blue-600 focus:bg-white caret-blue-600"
                                />
                            </div>
                        </div>

                        <div>
                            <label for="tipoUsuario" class="text-base font-medium text-gray-900">Tipo de Usuario</label>
                            <div class="mt-2.5">
                                <select name="tipoUsuario" id="tipoUsuario" class="block w-full p-4 text-black placeholder-gray-500 transition-all duration-200 border border-gray-200 rounded-md bg-gray-50 focus:outline-none focus:border-blue-600 focus:bg-white caret-blue-600">
                                    <option value="admin">Administrador</option>
                                    <option value="cajero">Cajero</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <button type="submit" class="inline-flex items-center justify-center w-full px-4 py-4 text-base font-semibold text-white transition-all duration-200 bg-blue-600 border border-transparent rounded-md focus:outline-none hover:bg-blue-700 focus:bg-blue-700">
                                Registrarse
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="flex items-center justify-center px-4 py-10 sm:py-16 lg:py-24 bg-gray-50 sm:px-6 lg:px-8">
            <div>
                <img class="w-full mx-auto" src="images/Login.png" alt="" />

                <div class="w-full max-w-md mx-auto xl:max-w-xl">
                    <h3 class="text-2xl font-bold text-center text-black">Ingresa al Sistema </h3>
                    <p class="leading-relaxed text-center text-gray-500 mt-2.5">------------</p>

                    <div class="flex items-center justify-center mt-10 space-x-3">
                        <div class="bg-orange-500 rounded-full w-20 h-1.5"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Notificación de éxito -->
<div id="successNotification" class="notification">
    <p>¡Registro exitoso!</p>
    <button onclick="redirectToLogin()">Ir a Inicio de Sesión</button>
</div>

<script>
    function redirectToLogin() {
        window.location.href = 'iniciarSesion.jsp';
    }

    // Notificación si se ha registrado correctamente
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('success') === 'true') {
            document.getElementById('successNotification').style.display = 'block';
        }
    }
</script>
</body>
</html>