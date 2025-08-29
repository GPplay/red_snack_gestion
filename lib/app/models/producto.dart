class Producto {
  String id;
  String nombre;
  String? descripcion;
  double costoFabricacion;
  double precioVenta;
  String emprendimientoId;

  Producto(
      {required this.id,
      required this.nombre,
      this.descripcion,
      required this.costoFabricacion,
      required this.precioVenta,
      required this.emprendimientoId});

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json['id'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
        costoFabricacion: (json['costoFabricacion'] as num).toDouble(),
        precioVenta: (json['precioVenta'] as num).toDouble(),
        emprendimientoId: json['emprendimientoId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
        'costoFabricacion': costoFabricacion,
        'precioVenta': precioVenta,
        'emprendimientoId': emprendimientoId,
      };
}
