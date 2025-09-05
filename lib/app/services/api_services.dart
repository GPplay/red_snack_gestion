import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5062'; // Cambia por tu URL

  // Ejemplo: obtener usuarios
  Future<List<dynamic>> getUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }

  //registrar usuarios
  Future<bool> registerUser({
    required String nombre,
    required String email,
    required String password,
    String? emprendimientoId,
    String? nombreEmprendimiento,
    String? descripcionEmprendimiento,
  }) async {
    final Map<String, dynamic> body = {
      "nombre": nombre,
      "email": email,
      "contrasena": password,
    };

    // Caso: unirse a un emprendimiento
    if (emprendimientoId != null) {
      body["emprendimientoId"] = emprendimientoId;
    }
    // Caso: crear emprendimiento
    else if (nombreEmprendimiento != null &&
        descripcionEmprendimiento != null) {
      body["nuevoEmprendimiento"] = {
        "nombre": nombreEmprendimiento,
        "descripcion": descripcionEmprendimiento,
      };
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/Usuarios'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return response.statusCode == 201;
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "contrasena": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data["token"];

      // Guardamos token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);

      return true;
    } else {
      return false;
    }
  }
}
