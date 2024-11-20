import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/controller/inventario_controller.dart';
import 'package:red_snack_gestion/app/models/producto.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart'; // Modelo Producto

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final InventarioController controller = InventarioController();

  void _mostrarDialogoAgregarProducto() {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController costoController = TextEditingController();
    final TextEditingController precioController = TextEditingController();
    final TextEditingController cantidadController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration:
                      const InputDecoration(labelText: 'Nombre del producto'),
                ),
                TextField(
                  controller: costoController,
                  decoration:
                      const InputDecoration(labelText: 'Costo de fabricación'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: precioController,
                  decoration:
                      const InputDecoration(labelText: 'Precio de venta'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: cantidadController,
                  decoration: const InputDecoration(
                      labelText: 'Cantidad en inventario'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final String nombre = nombreController.text;
                final double costo =
                    double.tryParse(costoController.text) ?? 0.0;
                final double precio =
                    double.tryParse(precioController.text) ?? 0.0;
                final int cantidad = int.tryParse(cantidadController.text) ?? 0;

                if (nombre.isNotEmpty &&
                    costo > 0 &&
                    precio > 0 &&
                    cantidad > 0) {
                  final producto = Producto(
                    id: controller.productos.length +
                        1, // Generar un ID incremental
                    nombre: nombre,
                    cantidadInventario: cantidad,
                    precioUnitario: precio,
                    costoFabricacion: costo,
                    emprendimientoId: 1, // Ajustar según la lógica de negocio
                  );

                  controller.agregarProducto(
                      producto); // Agregar el producto al controlador
                  Navigator.of(context).pop(); // Cerrar el diálogo
                  setState(() {}); // Actualizar la UI
                }
              },
              child: const Text('Agregar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo sin hacer nada
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Inventario', chatPage: Chats()),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: controller.productos.map((producto) {
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  producto.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Costo de fabricación: \$${producto.costoFabricacion?.toStringAsFixed(2) ?? "N/A"}'),
                    Text(
                        'Precio de venta: \$${producto.precioUnitario.toStringAsFixed(2)}'),
                    Text(
                        'Cantidad en inventario: ${producto.cantidadInventario}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      controller.eliminarProducto(
                          controller.productos.indexOf(producto));
                    });
                  },
                ),
                onTap: () {
                  // Puedes implementar navegación a una página de detalles
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Producto: ${producto.nombre}')),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAgregarProducto,
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
