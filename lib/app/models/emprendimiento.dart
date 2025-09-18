class Emprendimiento {
  String id;
  String nombre;
  String? descripcion;

  Emprendimiento({required this.id, required this.nombre, this.descripcion});

  factory Emprendimiento.fromJson(Map<String, dynamic> json) => Emprendimiento(
        id: json['id'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
      };
}
