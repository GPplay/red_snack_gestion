import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/controller/inventario_controller.dart';
import 'package:red_snack_gestion/app/models/inventario_producto.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/widget/mixin.dart';
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

// Añadimos el mixin aquí.
class HomeScreenState extends State<HomeScreen>
    with RefreshableMixin<HomeScreen> {
  final InventarioController inventarioController = InventarioController();

  @override
  void initState() {
    super.initState();
    // Llamamos a la función de recarga del mixin.
    refreshData();
  }

  // Ahora la lógica de recarga está en el mixin y la llamamos directamente.
  // Puedes sobreescribir este método si necesitas lógica adicional para el home.
  @override
  Future<void> refreshData() async {
    log('Refrescando datos del Home...');
    await super.refreshData();
    // Aquí puedes agregar tu lógica específica para actualizar los datos del home
    // await inventarioController.fetchData();
    log('Datos del Home refrescados.');
  }

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
              labelText: 'Producto',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            value: selectedItem,
            items: inventarioController.inventario.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item.producto.nombre),
              );
            }).toList(),
            onChanged: (InventarioProducto? newValue) {
              selectedItem = newValue;
            },
          ),
          const SizedBox(height: 16),
          // Campo para la cantidad
          TextField(
            controller: productCountController,
            decoration: InputDecoration(
              labelText: 'Cantidad',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedItem != null &&
                productCountController.text.isNotEmpty) {
              final int cantidad =
                  int.tryParse(productCountController.text) ?? 0;
              if (cantidad > 0) {
                // Aquí se agregaría la lógica para guardar la venta
                // y actualizar los datos.
                log('Venta agregada: ${selectedItem!.producto.nombre} - Cantidad: $cantidad');
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Por favor, ingresa una cantidad válida')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Por favor, selecciona un producto y la cantidad')),
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
      body: RefreshIndicator(
        // onRefresh ahora llama al método refreshData del mixin
        onRefresh: refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Se eliminó Expanded y se agregó SizedBox para una altura fija
                      const SizedBox(
                        height: 300,
                        child: TransaccionesEstado(),
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
