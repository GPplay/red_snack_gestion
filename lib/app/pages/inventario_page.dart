import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/controller/inventario_controller.dart';
import 'package:red_snack_gestion/app/pages/chat_page.dart';
import 'package:red_snack_gestion/app/pages/producto_page.dart';
import 'package:red_snack_gestion/app/services/api_services.dart';
import 'package:red_snack_gestion/app/services/inventario_api.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';
import 'package:red_snack_gestion/app/widget/boton_flotante.dart';
import 'package:red_snack_gestion/app/widget/formulario.dart';
import 'package:red_snack_gestion/app/widget/mixin.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen>
    with RefreshableMixin {
  final InventarioController controller = InventarioController();
  final ApiService _api = ApiService();

  @override
  Future<void> refreshData() async {
    await controller.cargarInventario();
    setState(() {}); // redibuja la UI con el inventario cargado
  }

  @override
  void initState() {
    super.initState();
    refreshData(); // cargar inventario al abrir la pantalla
  }

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
      final double costo = double.tryParse(resultado['costo'] ?? '0') ?? 0.0;
      final double precio = double.tryParse(resultado['precio'] ?? '0') ?? 0.0;
      final int cantidad = int.tryParse(resultado['cantidad'] ?? '0') ?? 0;

      if (nombre.isNotEmpty && costo > 0 && precio > 0 && cantidad > 0) {
        try {
          // 🚀 Crear producto en el backend
          final ok = await _api.crearProducto(
            nombre: nombre,
            descripcion: descripcion,
            costoFabricacion: costo,
            precioVenta: precio,
            cantidadInicial: cantidad,
          );

          if (ok) {
            // ✅ Refrescar inventario desde la API
            await refreshData();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Producto creado correctamente")),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al crear producto: $e")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Inventario', chatPage: Chats()),
      drawer: const SideMenu(),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : controller.inventario.isEmpty
                ? const Center(
                    child: Text(
                      "No hay nada en el inventario",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.inventario.length,
                    itemBuilder: (context, index) {
                      final item = controller.inventario[index];
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
                                  'Costo fabricación: \$${producto.costoFabricacion.toStringAsFixed(2)}'),
                              Text(
                                  'Precio venta: \$${producto.precioVenta.toStringAsFixed(2)}'),
                              Text('Cantidad: ${item.cantidad}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              try {
                                final ok =
                                    await _api.eliminarProducto(producto.id);

                                if (ok) {
                                  await refreshData(); // refresca la lista desde el backend
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Producto eliminado correctamente")),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Error al eliminar producto: $e")),
                                );
                              }
                            },
                          ),
                          onTap: () {
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
                    },
                  ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: _mostrarDialogoAgregarProducto,
      ),
    );
  }
}
