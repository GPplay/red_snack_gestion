import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Resultado genérico de la API
class ApiResult {
  final bool success;
  final String message;

  ApiResult({required this.success, required this.message});
}

class ApiService {
  static const String baseUrl = 'http://localhost:5062'; // URL de tu API

  /// Obtener usuarios (requiere token si tu API lo valida con [Authorize])
  Future<List<dynamic>> getUsuarios() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse('$baseUrl/api/Usuarios'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener usuarios: ${response.body}');
    }
  }

  /// Registrar usuarios
  Future<ApiResult> registerUser({
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

    // Caso: unirse a un emprendimiento existente
    if (emprendimientoId != null) {
      body["emprendimientoId"] = emprendimientoId;
    }
    // Caso: crear un nuevo emprendimiento
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

    if (response.statusCode == 201) {
      return ApiResult(success: true, message: "Usuario creado correctamente");
    } else {
      return ApiResult(
        success: false,
        message:
            response.body.isNotEmpty ? response.body : "Error al crear usuario",
      );
    }
  }

  /// Login de usuario
  Future<ApiResult> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "contrasena": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data["token"];

      // Guardar token en almacenamiento local
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);

      return ApiResult(success: true, message: "Login exitoso");
    } else {
      return ApiResult(
        success: false,
        message: response.body.isNotEmpty
            ? response.body
            : "Error al iniciar sesión",
      );
    }
  }
}
