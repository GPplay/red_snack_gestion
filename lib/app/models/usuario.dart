class Usuario {
  int id; // Clave primaria
  String nombre; // Nombre del usuario
  String email; // Correo electrónico
  String contrasena; // Contraseña
  String codigoAcceso; // Código de acceso

  // Constructor
  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
    required this.contrasena,
    required this.codigoAcceso,
  });

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'contrasena': contrasena,
      'codigoAcceso': codigoAcceso,
    };
  }

  // Método para crear una instancia de Usuario desde un JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      contrasena: json['contrasena'],
      codigoAcceso: json['codigoAcceso'],
    );
  }
}
