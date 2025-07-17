import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/models/producto.dart';
import 'package:red_snack_gestion/app/widget/formulario.dart';

class ProductoPage extends StatefulWidget {
  const ProductoPage({super.key, required Producto producto});

  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        title: const Text(
          'Producto',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono del producto
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 241, 241, 241),
                    border: Border.all(color: Colors.yellow, width: 2),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      )
                    ]),
                child: const Icon(
                  Icons.camera, // Cambia esto por el icono que desees
                  color: Colors.red,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              // Información del producto
              const Text(
                'Nombre:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Cantidad en inventario:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Precio:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Costo de fabricación:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Botón para agregar a inventario
              ElevatedButton(
                onPressed: () {
                  _showAddInventoryDialog(context); // Mostrar el diálogo
                },
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  backgroundColor: Colors.red, // Color de fondo
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Agregar a inventario',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para mostrar el diálogo de agregar a inventario
  void _showAddInventoryDialog(BuildContext context) async {
    // Llamamos al formulario dinámico
    final resultado = await FormularioDinamico.mostrarFormulario(
      context: context,
      titulo: "Agregar a Inventario",
      preguntas: [
        {
          'nombre':'cantidad', // Nombre del campo para identificar el resultado
          'label': 'Agregar número',
          'tipo': TextInputType.number,
          'hint': 'Ingresa una cantidad',
        },
      ],
      textoBoton: "Agregar", // Texto del botón de acción
      colorBoton: Colors.red, // Color del botón
      colorFondo: Colors.white, // Fondo del formulario
      colorTitulo: Colors.black, // Color del título
    );

    // Validar y procesar los resultados del formulario
    if (resultado != null) {
      final String? cantidadStr = resultado['cantidad'];
      if (cantidadStr != null && cantidadStr.isNotEmpty) {
        final int cantidad = int.tryParse(cantidadStr) ?? 0;

        // Aquí puedes manejar la cantidad ingresada, por ejemplo:
        // ignore: avoid_print
        print("Cantidad agregada al inventario: $cantidad");

        // Lógica adicional (e.g., actualizar inventario, llamar a controladores, etc.)
        // ...
      } else {
        // Manejo de error si no se ingresa un valor válido
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Por favor, ingresa una cantidad válida.")),
        );
      }
    }
  }
}
