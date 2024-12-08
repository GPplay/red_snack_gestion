import 'package:red_snack_gestion/app/models/producto.dart';
import 'package:http/http.dart' as http;

class InventarioController {
  // Lista de productos inicializada con algunos valores por defecto
  List<Producto> productos = [
    Producto(
      id: 1,
      nombre: 'Chips Papas',
      cantidadInventario: 100,
      precioUnitario: 1.00,
      costoFabricacion: 0.50,
      emprendimientoId: 1,
    ),
    Producto(
      id: 2,
      nombre: 'Refresco Cola',
      cantidadInventario: 50,
      precioUnitario: 1.20,
      costoFabricacion: 0.30,
      emprendimientoId: 1,
    ),
    Producto(
      id: 3,
      nombre: 'Chocolate Bar',
      cantidadInventario: 75,
      precioUnitario: 1.50,
      costoFabricacion: 0.80,
      emprendimientoId: 1,
    ),
  ];

  // ignore: prefer_typing_uninitialized_variables
  static var inventarioController;

  /// Función para eliminar un producto de la lista
  void eliminarProducto(int index) {
    if (index >= 0 && index < productos.length) {
      productos.removeAt(index);
    }
  }

  /// Función para agregar un producto a la lista
  void agregarProducto(Producto producto) {
    productos.add(producto);
  }

  /// Función para verificar si una imagen tiene dimensiones mayores a 500px
  Future<bool> esImagenMayorA500px(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        int? width = int.tryParse(response.headers['content-width'] ?? '0');
        int? height = int.tryParse(response.headers['content-height'] ?? '0');
        if (width != null && height != null && (width > 500 || height > 500)) {
          return true;
        }
      }
    } catch (e) {
      // Captura de errores y se asume que no se puede mostrar la imagen
      // ignore: avoid_print
      print('Error verificando la imagen: $e');
    }
    return false;
  }

  void actualizarInventario(int id, int i) {}

  totalVentas() {}

  totalGastos() {}

  totalGanancias() {}
}
