import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:red_snack_gestion/app/services/api_services.dart';

extension InventarioApi on ApiService {
  /// Obtener productos del inventario (ya vienen filtrados por el JWT en el backend)
  Future<List<dynamic>> getInventarioProductos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/InventarioProducto'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return []; // inventario vacío
    } else {
      throw Exception('Error al obtener productos: ${response.body}');
    }
  }

  /// Crear producto (y automáticamente se guarda en inventario)
  Future<bool> crearProducto({
    required String nombre,
    String? descripcion,
    required double costoFabricacion,
    required double precioVenta,
    required int cantidadInicial,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/Productos'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "nombre": nombre,
        "descripcion": descripcion,
        "costoFabricacion": costoFabricacion,
        "precioVenta": precioVenta,
        "cantidadInicial": cantidadInicial,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Error al crear producto: ${response.body}');
    }
  }

  /// Actualizar stock de un producto existente
  Future<bool> actualizarStock({
    required String productoId,
    required int nuevaCantidad,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.put(
      Uri.parse('${ApiService.baseUrl}/api/Productos/$productoId'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "id": productoId,
        "cantidadInicial": nuevaCantidad, // el backend lo actualiza
      }),
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Error al actualizar stock: ${response.body}');
    }
  }

  /// Eliminar producto (también lo quita del inventario del usuario)
  Future<bool> eliminarProducto(String productoId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.delete(
      Uri.parse('${ApiService.baseUrl}/api/Productos/$productoId'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Error al eliminar producto: ${response.body}');
    }
  }
}
