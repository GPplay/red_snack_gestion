class Venta {
  String id;
  DateTime fechaVenta;
  double totalVenta;
  String emprendimientoId;

  Venta({required this.id, required this.fechaVenta, required this.totalVenta, required this.emprendimientoId});

  factory Venta.fromJson(Map<String, dynamic> json) => Venta(
        id: json['id'],
        fechaVenta: DateTime.parse(json['fechaVenta']),
        totalVenta: (json['totalVenta'] as num).toDouble(),
        emprendimientoId: json['emprendimientoId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fechaVenta': fechaVenta.toIso8601String(),
        'totalVenta': totalVenta,
        'emprendimientoId': emprendimientoId,
      };
}
