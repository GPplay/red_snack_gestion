import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/controller/inventario_controller.dart';
import 'package:red_snack_gestion/app/models/producto.dart';
import 'package:red_snack_gestion/app/models/inventario_producto.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/pages/producto_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';
import 'package:red_snack_gestion/app/widget/boton_flotante.dart';
import 'package:red_snack_gestion/app/widget/formulario.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final InventarioController controller = InventarioController();

  void _mostrarDialogoAgregarProducto() async {
    final resultado = await FormularioDinamico.mostrarFormulario(
      context: context,
      titulo: 'Agregar Producto',
      preguntas: [
        {
          'nombre': 'nombre',
          'label': 'Nombre del producto',
          'tipo': TextInputType.text
        },
        {
          'nombre': 'descripcion',
          'label': 'Descripción',
          'tipo': TextInputType.text
        },
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
          'label': 'Cantidad inicial en inventario',
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
      final String nombre = resultado['nombre'] ?? '';
      final String descripcion = resultado['descripcion'] ?? '';
      final double costo =
          double.tryParse(resultado['costo'] ?? '0') ?? 0.0;
      final double precio =
          double.tryParse(resultado['precio'] ?? '0') ?? 0.0;
      final int cantidad =
          int.tryParse(resultado['cantidad'] ?? '0') ?? 0;

      if (nombre.isNotEmpty && costo > 0 && precio > 0 && cantidad > 0) {
        // Crear el Producto
        final producto = Producto(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          nombre: nombre,
          descripcion: descripcion,
          costoFabricacion: costo,
          precioVenta: precio,
          emprendimientoId: "1", // Ajustar según tu lógica
        );

        // Crear el InventarioProducto asociado
        final inventarioProducto = InventarioProducto(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          inventarioId: "1", // Ajustar según tu lógica
          productoId: producto.id,
          cantidad: cantidad,
          fechaActualizacion: DateTime.now(),
          costoActualEnStock: costo * cantidad,
          producto: producto,
        );

        controller.agregarProducto(inventarioProducto);
        setState(() {});
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
          children: controller.inventario.map((item) {
            final producto = item.producto;
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
                        'Descripción: ${producto.descripcion ?? "Sin descripción"}'),
                    Text(
                        'Costo de fabricación: \$${producto.costoFabricacion.toStringAsFixed(2)}'),
                    Text(
                        'Precio de venta: \$${producto.precioVenta.toStringAsFixed(2)}'),
                    Text('Cantidad en inventario: ${item.cantidad}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      controller.eliminarProducto(
                          controller.inventario.indexOf(item));
                    });
                  },
                ),
                onTap: () {
                  // Navegación a la página de detalles de producto
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductoPage(producto: producto),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: _mostrarDialogoAgregarProducto,
      ),
    );
  }
}
