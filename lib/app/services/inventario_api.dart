import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:red_snack_gestion/app/services/api_services.dart';

extension InventarioApi on ApiService {
  Future<String?> getInventarioId() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/Inventarios'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      if (data.isNotEmpty) {
        return data.first["id"]; // ✅ el inventario del emprendimiento
      }
      return null;
    } else {
      throw Exception('Error al obtener inventario: ${response.body}');
    }
  }

  Future<List<dynamic>> getInventarioProductos(String inventarioId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/InventarioProducto/$inventarioId'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Error al obtener productos del inventario: ${response.body}');
    }
  }
}


//${ApiService.baseUrl}