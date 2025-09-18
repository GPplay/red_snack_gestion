import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:red_snack_gestion/app/services/api_services.dart';

extension InventarioApi on ApiService {
  /// Obtener productos del inventario
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
      // No hay productos en inventario
      return [];
    } else {
      throw Exception(
          'Error al obtener productos del inventario: ${response.body}');
    }
  }

  /// Crear un nuevo producto y registrarlo en inventario
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

  /// Añadir stock a un producto existente
  Future<bool> agregarStock({
    required String productoId,
    required int cantidad,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/InventarioProducto'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "productoId": productoId,
        "cantidad": cantidad,
      }),
    );

    if (response.statusCode == 201) {
      return true; // Stock añadido correctamente
    } else if (response.statusCode == 409) {
      throw Exception(
          "El producto ya existe en el inventario. Usa PUT para actualizar la cantidad.");
    } else {
      throw Exception('Error al agregar stock: ${response.body}');
    }
  }
}


//${ApiService.baseUrl}