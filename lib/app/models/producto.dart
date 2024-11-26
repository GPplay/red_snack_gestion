class Producto {
  int id; // Clave primaria
  String nombre;
  int cantidadInventario;
  double precioUnitario;
  int emprendimientoId; // ID del emprendimiento asociado
  double? costoFabricacion; // Propiedad opcional

  // Constructor
  Producto({
    required this.id,
    required this.nombre,
    required this.cantidadInventario,
    required this.precioUnitario,
    required this.emprendimientoId,
    this.costoFabricacion,
  });

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'cantidadInventario': cantidadInventario,
      'precioUnitario': precioUnitario,
      'emprendimientoId': emprendimientoId,
      'costoFabricacion': costoFabricacion,
    };
  }

  // Método para crear una instancia de Producto desde un JSON
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      cantidadInventario: json['cantidadInventario'],
      precioUnitario: json['precioUnitario'].toDouble(),
      emprendimientoId: json['emprendimientoId'],
      costoFabricacion: json['costoFabricacion']?.toDouble(),
    );
  }
}
