<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Sistema de Punto de Venta</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
<section class="py-10 bg-white sm:py-16 lg:py-24">
    <div class="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div class="max-w-2xl mx-auto text-center">
            <h2 class="text-3xl font-bold leading-tight text-black sm:text-4xl lg:text-5xl">Bienvenido al Sistema de Punto de Venta</h2>
            <p class="max-w-xl mx-auto mt-4 text-base leading-relaxed text-gray-600">Aqui podras encontrar todos los aparatados referentes al control del Sistema</p>
        </div>

        <div class="grid max-w-md grid-cols-1 gap-6 mx-auto mt-8 text-center lg:max-w-full lg:mt-16 lg:grid-cols-3">
            <div class="overflow-hidden bg-white border-2 border-gray-100 rounded-md">
                <div class="p-8 xl:px-12">
                    <h3 class="text-base font-semibold text-purple-600">Inventario</h3>
                    <p class="mt-3 text-base text-gray-600">Control de tus Productos</p>

                    <ul class="inline-flex flex-col items-start space-y-5 text-left mt-9">
                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Agregar Productos </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Actualizar Productos </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="h-5 text-indigo-500 flex-shrink-0w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Eliminar Productos </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="h-5 text-indigo-500 flex-shrink-0w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Ver Stock </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="pb-0.5 text-base font-medium text-gray-900 border-b border-black border-dashed"> Actualizar Stock </span>
                        </li>
                    </ul>

                    <a href="gestionInventario.jsp" title="" class="inline-flex items-center justify-center px-10 py-4 mt-10 text-base font-semibold text-white transition-all duration-200 bg-blue-600 rounded-md hover:bg-blue-700 focus:bg-blue-700" role="button"> Acceder a Inventario </a>
                    <p class="mt-4 text-sm text-gray-500"></p>
                </div>
            </div>

            <div class="overflow-hidden bg-white border-2 border-gray-100 rounded-md shadow-lg">
                <div class="p-8 xl:px-12">
                    <h3 class="text-base font-semibold text-purple-600">Ventas</h3>
                    <p class="mt-3 text-base text-gray-600">Gesti&oacute;n de Ventas</p>

                    <ul class="inline-flex flex-col items-start space-y-5 text-left mt-9">
                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Agregar productos al Carrito </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Aplicar Descuentos </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Calculo del monto total </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Control de Ventas </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="pb-0.5 text-base font-medium text-gray-900 border-b border-black border-dashed"> Actualizaci&oacute;n del Stock Post-Venta</span>
                        </li>
                    </ul>

                    <a href="venta.jsp" title="" class="inline-flex items-center justify-center px-10 py-4 mt-10 text-base font-semibold text-white transition-all duration-200 rounded-md bg-gradient-to-r from-fuchsia-600 to-blue-600 hover:opacity-80 focus:opacity-80" role="button"> Acceder a Ventas </a>
                    <p class="mt-4 text-sm text-gray-500"></p>
                </div>
            </div>

            <div class="overflow-hidden bg-white border-2 border-gray-100 rounded-md">
                <div class="p-8 xl:px-12">
                    <h3 class="text-base font-semibold text-purple-600">Descuentos</h3>
                    <p class="mt-3 text-base text-gray-600">Control de tus Descuentos</p>

                    <ul class="inline-flex flex-col items-start space-y-5 text-left mt-9">
                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Agregar Descuentos </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Buscar Descuentos </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Actualizar Descuentos </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Eliminar Descuentos </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="pb-0.5 text-base font-medium text-gray-900 border-b border-black border-dashed">Actualizar Stock de Descuentos</span>
                        </li>
                    </ul>

                    <a href="gestionDescuento.jsp" title="" class="inline-flex items-center justify-center px-10 py-4 mt-10 text-base font-semibold text-white transition-all duration-200 bg-blue-600 rounded-md hover:bg-blue-700 focus:bg-blue-700" role="button"> Acceder a Descuentos </a>
                    <p class="mt-4 text-sm text-gray-500"></p>
                </div>
            </div>

            <div class="overflow-hidden bg-white border-2 border-gray-100 rounded-md shadow-lg">
                <div class="p-8 xl:px-12">
                    <h3 class="text-base font-semibold text-purple-600">Clientes</h3>
                    <p class="mt-3 text-base text-gray-600">Gesti&oacute;n de Clientes</p>

                    <ul class="inline-flex flex-col items-start space-y-5 text-left mt-9">
                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Agregar Cleintes</span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Actualizar Clientes </span>
                        </li>

                        <li class="inline-flex items-center space-x-2">
                            <svg class="flex-shrink-0 w-5 h-5 text-indigo-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            <span class="text-base font-medium text-gray-900"> Eliminar Clientes </span>
                        </li>
                    </ul>

                    <a href="gestionCliente.jsp" title="" class="inline-flex items-center justify-center px-10 py-4 mt-10 text-base font-semibold text-white transition-all duration-200 rounded-md bg-gradient-to-r from-fuchsia-600 to-blue-600 hover:opacity-80 focus:opacity-80" role="button"> Acceder a Clientes </a>
                    <p class="mt-4 text-sm text-gray-500"></p>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>