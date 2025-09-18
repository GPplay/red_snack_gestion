class ReporteFinancieroMensual {
  String id;
  String emprendimientoId;
  int ano;
  int mes;
  double totalGastosFabricacionMes;
  double totalGananciasVentasMes;
  DateTime fechaUltimaActualizacion;

  ReporteFinancieroMensual(
      {required this.id,
      required this.emprendimientoId,
      required this.ano,
      required this.mes,
      required this.totalGastosFabricacionMes,
      required this.totalGananciasVentasMes,
      required this.fechaUltimaActualizacion});

  factory ReporteFinancieroMensual.fromJson(Map<String, dynamic> json) =>
      ReporteFinancieroMensual(
        id: json['id'],
        emprendimientoId: json['emprendimientoId'],
        ano: json['ano'],
        mes: json['mes'],
        totalGastosFabricacionMes:
            (json['totalGastosFabricacionMes'] as num).toDouble(),
        totalGananciasVentasMes:
            (json['totalGananciasVentasMes'] as num).toDouble(),
        fechaUltimaActualizacion:
            DateTime.parse(json['fechaUltimaActualizacion']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'emprendimientoId': emprendimientoId,
        'ano': ano,
        'mes': mes,
        'totalGastosFabricacionMes': totalGastosFabricacionMes,
        'totalGananciasVentasMes': totalGananciasVentasMes,
        'fechaUltimaActualizacion': fechaUltimaActualizacion.toIso8601String(),
      };
}
