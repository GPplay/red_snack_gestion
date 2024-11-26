import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';

class HistorialVentas extends StatefulWidget {
  const HistorialVentas({super.key});

  @override
  State<HistorialVentas> createState() => _HistorialVentasState();
}

class _HistorialVentasState extends State<HistorialVentas> {
  // Simulación de datos de ventas
  final List<Map<String, dynamic>> ventas = [
    {'venta': 50000, 'producto': 'Deditos', 'inventario': -100},
    {'venta': 50000, 'producto': 'Deditos', 'inventario': -100},
    {'venta': 50000, 'producto': 'Deditos', 'inventario': -100},
    {'venta': 50000, 'producto': 'Deditos', 'inventario': -100},
    {'venta': 50000, 'producto': 'Deditos', 'inventario': -100},
    {'venta': 50000, 'producto': 'Deditos', 'inventario': -100},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Historial', chatPage: Chats()),
      drawer: const SideMenu(),
      body: ListView.builder(
        itemCount: ventas.length,
        itemBuilder: (context, index) {
          final venta = ventas[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Venta: ${venta['venta']}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Producto: ${venta['producto']}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Inventario: ${venta['inventario']}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
