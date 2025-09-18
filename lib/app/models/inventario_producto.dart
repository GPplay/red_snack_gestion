import 'package:uuid/uuid.dart';
import 'producto.dart';

var uuid = Uuid();

class InventarioProducto {
  String id;
  String inventarioId;
  String productoId;
  int cantidad;
  DateTime fechaActualizacion;
  double costoActualEnStock;

  /// Relación con Producto (opcional pero necesaria en tu app)
  Producto producto;

  InventarioProducto({
    String? id,
    required this.inventarioId,
    required this.productoId,
    required this.cantidad,
    required this.fechaActualizacion,
    required this.costoActualEnStock,
    required this.producto,
  }) : id = id ?? uuid.v4();

  factory InventarioProducto.fromJson(Map<String, dynamic> json) =>
      InventarioProducto(
        id: json['id'],
        inventarioId: json['inventarioId'],
        productoId: json['productoId'],
        cantidad: json['cantidad'],
        fechaActualizacion: DateTime.parse(json['fechaActualizacion']),
        costoActualEnStock: (json['costoActualEnStock'] as num).toDouble(),
        producto: Producto.fromJson(json['producto']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'inventarioId': inventarioId,
        'productoId': productoId,
        'cantidad': cantidad,
        'fechaActualizacion': fechaActualizacion.toIso8601String(),
        'costoActualEnStock': costoActualEnStock,
        'producto': producto.toJson(),
      };
}
