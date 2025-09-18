class Inventario {
  String id;
  DateTime fechaActualizacion;
  String emprendimientoId;

  Inventario({required this.id, required this.fechaActualizacion, required this.emprendimientoId});

  factory Inventario.fromJson(Map<String, dynamic> json) => Inventario(
        id: json['id'],
        fechaActualizacion: DateTime.parse(json['fechaActualizacion']),
        emprendimientoId: json['emprendimientoId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fechaActualizacion': fechaActualizacion.toIso8601String(),
        'emprendimientoId': emprendimientoId,
      };
}
