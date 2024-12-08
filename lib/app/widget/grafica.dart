import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TransaccionesEstado extends StatefulWidget {
  const TransaccionesEstado({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransaccionesEstadoState createState() => _TransaccionesEstadoState();
}

class _TransaccionesEstadoState extends State<TransaccionesEstado> {
  late List<ChartData> chartData;

  @override
  void initState() {
    super.initState();
    // Inicializamos datos de ejemplo
    chartData = [
      ChartData('Ene', 80, 100),
      ChartData('Feb', 40, 90),
      ChartData('Mar', 70, 85),
      ChartData('Abr', 50, 60),
      ChartData('May', 100, 120),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Grafica de transacciones'),
          automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SfCartesianChart(
          primaryXAxis: const CategoryAxis(
            title: AxisTitle(text: 'Meses'),
          ),
          primaryYAxis: const NumericAxis(
            title: AxisTitle(text: ''),
          ),
          series: <CartesianSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.mes,
              yValueMapper: (ChartData data, _) => data.valor1,
              name: 'Costos',
              color: Colors.red.shade300,
            ),
            ColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.mes,
              yValueMapper: (ChartData data, _) => data.valor2,
              name: 'ganancias',
              color: Colors.green.shade700,
            ),
          ],
          legend: const Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
        ),
      ),
    );
  }
}

class ChartData {
  final String mes;
  final double valor1;
  final double valor2;

  ChartData(this.mes, this.valor1, this.valor2);
}
