class Usuario {
  String id;
  String nombre;
  String email;
  String contrasena;
  String emprendimientoId;

  Usuario(
      {required this.id,
      required this.nombre,
      required this.email,
      required this.contrasena,
      required this.emprendimientoId});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        nombre: json['nombre'],
        email: json['email'],
        contrasena: json['contrasena'],
        emprendimientoId: json['emprendimientoId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'email': email,
        'contrasena': contrasena,
        'emprendimientoId': emprendimientoId,
      };
}
