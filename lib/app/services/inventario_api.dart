import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:red_snack_gestion/app/services/api_services.dart';

extension InventarioApi on ApiService {
  Future<List<dynamic>> getInventario() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/Inventario'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener inventario: ${response.body}');
    }
  }
}
