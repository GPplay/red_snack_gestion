class Transacion {
  int id; // Clave primaria
  String
      fecha; // Fecha como cadena (puede convertirse a DateTime si es necesario)
  String tipo; // Tipo de transacción
  double monto;
  String? descripcion; // Propiedad opcional
  int emprendimientoId; // ID del emprendimiento asociado

  // Constructor
  Transacion({
    required this.id,
    required this.fecha,
    required this.tipo,
    required this.monto,
    this.descripcion,
    required this.emprendimientoId,
  });

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha,
      'tipo': tipo,
      'monto': monto,
      'descripcion': descripcion,
      'emprendimientoId': emprendimientoId,
    };
  }

  // Método para crear una instancia de Transacion desde un JSON
  factory Transacion.fromJson(Map<String, dynamic> json) {
    return Transacion(
      id: json['id'],
      fecha: json['fecha'],
      tipo: json['tipo'],
      monto: json['monto'].toDouble(),
      descripcion: json['descripcion'],
      emprendimientoId: json['emprendimientoId'],
    );
  }
}
