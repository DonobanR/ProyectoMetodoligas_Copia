from flask import Flask, request, jsonify
from flask_cors import CORS
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
import base64
import json

app = Flask(__name__)
CORS(app)  # Habilitar CORS para todas las rutas

# Llave de encriptación (debe ser la misma que en el cliente)
encryption_key = b'mysecretkey12345'  # Clave de 16 bytes

def unpad(s):
    return s[:-ord(s[len(s)-1:])]

def decrypt_data(encrypted_data):
    encrypted_data_bytes = base64.b64decode(encrypted_data)
    cipher = Cipher(algorithms.AES(encryption_key), modes.ECB(), backend=default_backend())
    decryptor = cipher.decryptor()
    decrypted_data = decryptor.update(encrypted_data_bytes) + decryptor.finalize()
    return unpad(decrypted_data).decode('utf-8')

@app.route('/procesarPagoTarjeta', methods=['POST'])
def procesar_pago_tarjeta():
    try:
        # Obtener los datos encriptados
        data = request.get_json()
        if not data or 'encryptedData' not in data:
            raise ValueError("No encrypted data found in the request.")

        encrypted_data = data['encryptedData']
        print(f"Datos encriptados recibidos: {encrypted_data}")

        # Desencriptar los datos
        decrypted_data = decrypt_data(encrypted_data)
        print(f"Datos desencriptados: {decrypted_data}")

        datos_tarjeta = json.loads(decrypted_data)
        print(f"Datos de la tarjeta: {datos_tarjeta}")

        numero_tarjeta = datos_tarjeta['numeroTarjeta']
        nombre_titular = datos_tarjeta['nombreTitular']
        fecha_expiracion = datos_tarjeta['fechaExpiracion']
        cvv = datos_tarjeta['cvv']

        # Aquí puedes agregar la lógica para procesar el pago
        print(f"Procesando pago para la tarjeta: {numero_tarjeta}")

        # Responder con un mensaje de éxito
        return jsonify({"status": "success", "message": "Pago procesado exitosamente."}), 200
    except Exception as e:
        print(f"Error al procesar el pago: {e}")
        return jsonify({"status": "error", "message": f"Error al procesar el pago: {e}"}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
