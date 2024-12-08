class Emprendimiento {
  int id; // Clave primaria
  String nombre;
  String? descripcion; // Propiedad opcional
  String codigoAcceso;

  // Constructor
  Emprendimiento({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.codigoAcceso,
  });

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'codigoAcceso': codigoAcceso,
    };
  }

  // Método para crear una instancia de Emprendimiento desde un JSON
  factory Emprendimiento.fromJson(Map<String, dynamic> json) {
    return Emprendimiento(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      codigoAcceso: json['codigoAcceso'],
    );
  }
}
