import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/controller/inventario_controller.dart';
import 'package:red_snack_gestion/app/models/producto.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/pages/producto_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';
import 'package:red_snack_gestion/app/widget/formulario.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final InventarioController controller = InventarioController();

  void _mostrarDialogoAgregarProducto() async {
    // Mostrar el formulario dinámico
    final resultado = await FormularioDinamico.mostrarFormulario(
      context: context,
      titulo: 'Agregar Producto',
      preguntas: [
        {'nombre': 'nombre', 'label': 'Nombre del producto'},
        {
          'nombre': 'costo',
          'label': 'Costo de fabricación',
          'tipo': TextInputType.number
        },
        {
          'nombre': 'precio',
          'label': 'Precio de venta',
          'tipo': TextInputType.number
        },
        {
          'nombre': 'cantidad',
          'label': 'Cantidad en inventario',
          'tipo': TextInputType.number
        },
      ],
      textoBoton: 'Agregar',
      colorBoton: Colors.red,
      colorFondo: Colors.white,
      colorTitulo: Colors.black,
      colorTextoCampos: Colors.black,
    );

    if (resultado != null) {
      // Validar y agregar el producto al controlador
      final String nombre = resultado['nombre'] ?? '';
      final double costo = double.tryParse(resultado['costo'] ?? '0') ?? 0.0;
      final double precio = double.tryParse(resultado['precio'] ?? '0') ?? 0.0;
      final int cantidad = int.tryParse(resultado['cantidad'] ?? '0') ?? 0;

      if (nombre.isNotEmpty && costo > 0 && precio > 0 && cantidad > 0) {
        final producto = Producto(
          id: controller.productos.length + 1, // Generar un ID incremental
          nombre: nombre,
          cantidadInventario: cantidad,
          precioUnitario: precio,
          costoFabricacion: costo,
          emprendimientoId: 1, // Ajustar según la lógica de negocio
        );

        controller
            .agregarProducto(producto); // Agregar el producto al controlador
        setState(() {}); // Actualizar la UI
      }
    }
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
                  // Navegación a una página de detalles
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductoPage(producto: producto)),
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
