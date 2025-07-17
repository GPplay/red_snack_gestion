import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/controller/inventario_controller.dart';
import 'package:red_snack_gestion/app/models/producto.dart';
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
    Producto? selectedProduct;
    final TextEditingController productCountController =
        TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Agregar Venta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Desplegable para seleccionar el producto
          DropdownButtonFormField<Producto>(
            decoration: InputDecoration(
              labelText: 'Seleccione el producto',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            value: selectedProduct, // Valor inicial
            items: inventarioController.productos
                .map<DropdownMenuItem<Producto>>((producto) {
              return DropdownMenuItem<Producto>(
                value: producto,
                child: Text(producto.nombre),
              );
            }).toList(),
            onChanged: (Producto? newValue) {
              selectedProduct = newValue; // Guardar el producto seleccionado
            },
          ),
          const SizedBox(height: 10),
          // Campo para ingresar la cantidad de productos
          TextField(
            controller: productCountController,
            decoration: InputDecoration(
              labelText: 'Numero de productos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            keyboardType: TextInputType.number, // Permitir solo números
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Validación de los datos
            if (selectedProduct != null &&
                productCountController.text.isNotEmpty) {
              final int cantidadSolicitada =
                  int.tryParse(productCountController.text) ?? 0;

              if (cantidadSolicitada > 0 &&
                  cantidadSolicitada <= selectedProduct!.cantidadInventario) {
                // Actualizar inventario
                setState(() {
                  inventarioController.actualizarInventario(selectedProduct!.id,
                      selectedProduct!.cantidadInventario - cantidadSolicitada);
                });

                log('Venta registrada: ${selectedProduct!.nombre}, Cantidad: $cantidadSolicitada');
                Navigator.of(context).pop(); // Cerrar el diálogo
              } else {
                // Mostrar error si no hay suficiente inventario
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Inventario insuficiente. Disponible: ${selectedProduct!.cantidadInventario}'),
                  ),
                );
              }
            } else {
              // Mostrar mensaje de error si faltan datos
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
              child: TransaccionesEstado(),
            ),
            const SizedBox(height: 5),
            Tarjetas(text: 'Ventas: ${inventarioController.totalVentas()}'),
            const SizedBox(height: 10),
            Tarjetas(text: 'Gastos: ${inventarioController.totalGastos()}'),
            const SizedBox(height: 10),
            Tarjetas(
                text: 'Ganancias: ${inventarioController.totalGanancias()}'),
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
