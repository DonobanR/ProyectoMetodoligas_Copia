<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inicio</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
<section class="py-10 bg-white sm:py-16 lg:py-24">
    <div class="px-4 mx-auto sm:px-6 lg:px-8 max-w-7xl">
        <div class="max-w-2xl mx-auto text-center">
            <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="4" height="4" fill="currentColor" viewBox="0 0 24 24">
                <path fill-rule="evenodd" d="M14 7h-4v3a1 1 0 0 1-2 0V7H6a1 1 0 0 0-.997.923l-.917 11.924A2 2 0 0 0 6.08 22h11.84a2 2 0 0 0 1.994-2.153l-.917-11.924A1 1 0 0 0 18 7h-2v3a1 1 0 1 1-2 0V7Zm-2-3a2 2 0 0 0-2 2v1H8V6a4 4 0 0 1 8 0v1h-2V6a2 2 0 0 0-2-2Z" clip-rule="evenodd"/>
            </svg>
            <h2 class="mt-10 text-3xl font-bold leading-tight text-black sm:text-4xl lg:text-5xl"><B>¡Bienvenido al Sistema Severeg!</B></h2>
            <p class="max-w-xl mx-auto mt-4 text-base leading-relaxed text-gray-600">
                Con Severeg, tienes a tu disposición una solución completa para la gestión de tu tienda de electrónica y electrodomésticos.
                Nuestro sistema integra un punto de venta intuitivo que te permite realizar ventas, aplicar descuentos, gestionar devoluciones y registrar pagos de manera eficiente.
            </p>
        </div>

        <div class="flex flex-col items-center justify-center mt-8 space-y-4 md:space-y-0 md:space-x-4 md:flex-row lg:mt-12">
            <a href="iniciarSesion.jsp" title="" class="inline-flex items-center justify-center px-4 py-4 text-black transition-all duration-200 border-2 border-black rounded-md hover:bg-black hover:text-white focus:bg-black focus:text-white" role="button">
                <svg class="w-6 h-6 mr-2 -ml-1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                    <path fill-rule="evenodd" d="M12 4a4 4 0 1 0 0 8 4 4 0 0 0 0-8Zm-2 9a4 4 0 0 0-4 4v1a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2v-1a4 4 0 0 0-4-4h-4Z" clip-rule="evenodd"/>
                </svg>
                Iniciar Sesi&oacute;n
            </a>

            <a href="registarUsuario.jsp" title="" class="inline-flex items-center justify-center px-6 py-4 text-black transition-all duration-200 border-2 border-black rounded-md hover:bg-black hover:text-white focus:bg-black focus:text-white" role="button">
                <svg class="w-6 h-6 mr-2 -ml-1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12h4m-2 2v-4M4 18v-1a3 3 0 0 1 3-3h4a3 3 0 0 1 3 3v1a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1Zm8-10a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"/>
                </svg>
                Registrarse
            </a>
        </div>

        <p class="mt-6 text-base text-center text-gray-600">Simplifica la gestión de tu tienda y maximiza tu eficiencia con Severeg.</p>
    </div>
</section>
</body>
</html>
