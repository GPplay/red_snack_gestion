import 'package:red_snack_gestion/app/models/producto.dart';
import 'package:red_snack_gestion/app/models/inventario_producto.dart';

class InventarioController {
  // Lista inicial de inventario con productos
  List<InventarioProducto> inventario = [
    InventarioProducto(
      id: "1",
      inventarioId: "1",
      productoId: "p1",
      cantidad: 100,
      fechaActualizacion: DateTime.now(),
      costoActualEnStock: 50,
      producto: Producto(
        id: "p1",
        nombre: 'Chips Papas',
        descripcion: 'Papas fritas clásicas',
        costoFabricacion: 0.50,
        precioVenta: 1.00,
        emprendimientoId: "1",
      ),
    ),
    InventarioProducto(
      id: "2",
      inventarioId: "1",
      productoId: "p2",
      cantidad: 50,
      fechaActualizacion: DateTime.now(),
      costoActualEnStock: 15,
      producto: Producto(
        id: "p2",
        nombre: 'Refresco Cola',
        descripcion: 'Bebida gaseosa 350ml',
        costoFabricacion: 0.30,
        precioVenta: 1.20,
        emprendimientoId: "1",
      ),
    ),
    InventarioProducto(
      id: "3",
      inventarioId: "1",
      productoId: "p3",
      cantidad: 75,
      fechaActualizacion: DateTime.now(),
      costoActualEnStock: 60,
      producto: Producto(
        id: "p3",
        nombre: 'Chocolate Bar',
        descripcion: 'Barra de chocolate 40g',
        costoFabricacion: 0.80,
        precioVenta: 1.50,
        emprendimientoId: "1",
      ),
    ),
  ];

  /// Agregar producto al inventario
  void agregarProducto(InventarioProducto inventarioProducto) {
    inventario.add(inventarioProducto);
  }

  /// Eliminar producto del inventario por índice
  void eliminarProducto(int index) {
    if (index >= 0 && index < inventario.length) {
      inventario.removeAt(index);
    }
  }

  /// Actualizar cantidad de un producto en inventario
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
