from flask import Flask, request, jsonify
from flask_cors import CORS
import json

app = Flask(__name__)
CORS(app)  # Habilitar CORS para todas las rutas

@app.route('/procesarPagoTarjeta', methods=['POST'])
def procesar_pago_tarjeta():
    try:
        datos_tarjeta = request.get_json()

        numero_tarjeta = datos_tarjeta['numeroTarjeta']
        nombre_titular = datos_tarjeta['nombreTitular']
        fecha_expiracion = datos_tarjeta['fechaExpiracion']
        cvv = datos_tarjeta['cvv']

        # Aquí puedes agregar la lógica para procesar el pago
        # Por ejemplo, validar los datos, conectarse con una pasarela de pago, etc.
        # Para este ejemplo, simplemente imprimimos los datos recibidos.

        print(f"Datos de la tarjeta recibidos: {datos_tarjeta}")

        # Responder con un mensaje de éxito
        return jsonify({"status": "success", "message": "Pago procesado exitosamente"}), 200
    except Exception as e:
        print(f"Error al procesar el pago: {e}")
        return jsonify({"status": "error", "message": "Error al procesar el pago"}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
