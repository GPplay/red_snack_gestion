import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/controller/inventario_controller.dart';
import 'package:red_snack_gestion/app/models/inventario_producto.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';
import 'package:red_snack_gestion/app/widget/boton_flotante.dart';
import 'package:red_snack_gestion/app/widget/grafica.dart';
import 'package:red_snack_gestion/app/widget/tarjetas.dart';
import 'dart:developer';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final InventarioController inventarioController = InventarioController();

  Widget _buildAddSaleDialog(BuildContext context) {
    InventarioProducto? selectedItem;
    final TextEditingController productCountController =
        TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Agregar Venta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Desplegable para seleccionar el producto
          DropdownButtonFormField<InventarioProducto>(
            decoration: InputDecoration(
              labelText: 'Seleccione el producto',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            value: selectedItem,
            items: inventarioController.inventario
                .map<DropdownMenuItem<InventarioProducto>>((item) {
              return DropdownMenuItem<InventarioProducto>(
                value: item,
                child: Text(item.producto.nombre),
              );
            }).toList(),
            onChanged: (InventarioProducto? newValue) {
              setState(() {
                selectedItem = newValue;
              });
            },
          ),
          const SizedBox(height: 10),
          // Campo para ingresar la cantidad de productos
          TextField(
            controller: productCountController,
            decoration: InputDecoration(
              labelText: 'Número de productos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (selectedItem != null &&
                productCountController.text.isNotEmpty) {
              final int cantidadSolicitada =
                  int.tryParse(productCountController.text) ?? 0;

              if (cantidadSolicitada > 0 &&
                  cantidadSolicitada <= selectedItem!.cantidad) {
                // Actualizar inventario
                setState(() {
                  inventarioController.actualizarInventario(
                    selectedItem!.productoId,
                    selectedItem!.cantidad - cantidadSolicitada,
                  );
                });

                log('Venta registrada: ${selectedItem!.producto.nombre}, '
                    'Cantidad: $cantidadSolicitada');
                Navigator.of(context).pop();
              } else {
                // Mostrar error si no hay suficiente inventario
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Inventario insuficiente. Disponible: ${selectedItem!.cantidad}'),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Por favor, seleccione un producto y la cantidad')),
              );
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Inicio', chatPage: Chats()),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: TransaccionesEstado(), // <- tu widget de gráfica/estado
            ),
            const SizedBox(height: 5),
            Tarjetas(
                text:
                    'Ventas: \$${inventarioController.totalVentas().toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            Tarjetas(
                text:
                    'Gastos: \$${inventarioController.totalGastos().toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            Tarjetas(
                text:
                    'Ganancias: \$${inventarioController.totalGanancias().toStringAsFixed(2)}'),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildAddSaleDialog(context);
            },
          );
        },
      ),
    );
  }
}
