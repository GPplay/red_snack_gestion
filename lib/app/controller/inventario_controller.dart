import 'package:red_snack_gestion/app/models/producto.dart';
import 'package:red_snack_gestion/app/models/inventario_producto.dart';
import 'package:red_snack_gestion/app/services/api_services.dart';
import 'package:red_snack_gestion/app/services/inventario_api.dart';

class InventarioController {
  List<InventarioProducto> inventario = [];
  final ApiService _api = ApiService();

  /// Obtener inventario desde la API
  Future<void> cargarInventario() async {
    final data = await _api.getInventarioProductos();

    inventario = data.map<InventarioProducto>((json) {
      final productoJson = json["producto"];

      final producto = Producto(
        id: productoJson["id"].toString(),
        nombre: productoJson["nombre"] ?? "",
        descripcion: productoJson["descripcion"] ?? "",
        costoFabricacion:
            double.tryParse(productoJson["costoFabricacion"].toString()) ?? 0.0,
        precioVenta:
            double.tryParse(productoJson["precioVenta"].toString()) ?? 0.0,
        emprendimientoId: productoJson["emprendimientoId"].toString(),
      );

      return InventarioProducto(
        id: json["id"].toString(),
        inventarioId: json["inventarioId"].toString(),
        productoId: producto.id,
        cantidad: json["cantidad"] ?? 0,
        fechaActualizacion:
            DateTime.tryParse(json["fechaActualizacion"] ?? "") ??
                DateTime.now(),
        costoActualEnStock:
            double.tryParse(json["costoActualEnStock"].toString()) ?? 0.0,
        producto: producto,
      );
    }).toList();
  }

  /// Agregar producto localmente (puedes extenderlo con POST a la API)
  void agregarProducto(InventarioProducto inventarioProducto) {
    inventario.add(inventarioProducto);
  }

  /// Eliminar producto localmente (puedes extenderlo con DELETE a la API)
  void eliminarProducto(int index) {
    if (index >= 0 && index < inventario.length) {
      inventario.removeAt(index);
    }
  }

  /// Actualizar cantidad de un producto localmente
  void actualizarInventario(String productoId, int nuevaCantidad) {
    final item = inventario.firstWhere(
      (i) => i.productoId == productoId,
      orElse: () => throw Exception("Producto no encontrado"),
    );

    item.cantidad = nuevaCantidad;
    item.fechaActualizacion = DateTime.now();
  }

  /// Calcular el total de ventas (precioVenta * cantidad en inventario)
  double totalVentas() {
    return inventario.fold(
      0,
      (sum, item) => sum + (item.producto.precioVenta * item.cantidad),
    );
  }

  /// Calcular el total de gastos de fabricación
  double totalGastos() {
    return inventario.fold(
      0,
      (sum, item) => sum + (item.producto.costoFabricacion * item.cantidad),
    );
  }

  /// Calcular ganancias (Ventas - Gastos)
  double totalGanancias() {
    return totalVentas() - totalGastos();
  }
}
