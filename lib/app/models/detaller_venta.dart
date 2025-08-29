class DetalleVenta {
  String id;
  String ventaId;
  String productoId;
  int cantidad;
  double precio;
  DateTime fechaCreacion;

  DetalleVenta({required this.id, required this.ventaId, required this.productoId, required this.cantidad, required this.precio, required this.fechaCreacion});

  factory DetalleVenta.fromJson(Map<String, dynamic> json) => DetalleVenta(
        id: json['id'],
        ventaId: json['ventaId'],
        productoId: json['productoId'],
        cantidad: json['cantidad'],
        precio: (json['precio'] as num).toDouble(),
        fechaCreacion: DateTime.parse(json['fechaCreacion']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ventaId': ventaId,
        'productoId': productoId,
        'cantidad': cantidad,
        'precio': precio,
        'fechaCreacion': fechaCreacion.toIso8601String(),
      };
}
