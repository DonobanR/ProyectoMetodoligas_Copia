<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesi&oacute;n</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .notification {
            display: none; /* Oculto por defecto */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #f44336;
            color: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
            text-align: center;
        }
        .notification button {
            margin-top: 10px;
            padding: 10px;
            background-color: white;
            color: #f44336;
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
                <h2 class="text-3xl font-bold leading-tight text-black sm:text-4xl">Iniciar Sesi&oacute;n</h2>
                <p class="mt-2 text-base text-gray-600">¿No tienes una cuenta? <a href="registarUsuario.jsp" title="" class="font-medium text-blue-600 transition-all duration-200 hover:text-blue-700 hover:underline focus:text-blue-700">Create una cuenta</a></p>

                <form action="login" method="POST" class="mt-8">
                    <div class="space-y-5">
                        <div>
                            <label for="usuario" class="text-base font-medium text-gray-900"> Usuario </label>
                            <div class="mt-2.5">
                                <input
                                        type="text"
                                        name="usuario"
                                        id="usuario"
                                        placeholder="Ingrese su usuario"
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
                            <button type="submit" class="inline-flex items-center justify-center w-full px-4 py-4 text-base font-semibold text-white transition-all duration-200 bg-blue-600 border border-transparent rounded-md focus:outline-none hover:bg-blue-700 focus:bg-blue-700">Ingresar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="flex items-center justify-center px-4 py-10 sm:py-16 lg:py-24 bg-gray-50 sm:px-6 lg:px-8">
            <div>
                <img class="w-full mx-auto" src="images/Login.png" alt="" />

                <div class="w-full max-w-md mx-auto xl:max-w-xl">
                    <h3 class="text-2xl font-bold text-center text-black">Ingresa al Sistema</h3>
                    <p class="leading-relaxed text-center text-gray-500 mt-2.5">------------</p>

                    <div class="flex items-center justify-center mt-10 space-x-3">
                        <div class="bg-orange-500 rounded-full w-20 h-1.5"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Notificación de error -->
<div id="errorNotification" class="notification">
    <p>Usuario o contraseña incorrectos. Inténtalo de nuevo.</p>
    <button onclick="closeNotification()">Cerrar</button>
</div>

<script>
    function closeNotification() {
        document.getElementById('errorNotification').style.display = 'none';
    }

    // Mostrar notificación si hay error
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('error') === 'true') {
            document.getElementById('errorNotification').style.display = 'block';
        }
    }
</script>
</body>
</html>