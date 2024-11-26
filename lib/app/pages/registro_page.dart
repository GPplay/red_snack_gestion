// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _codigoAccesoController =
      TextEditingController(); // Agregué este controlador
  final _nombreEmprendimientoController = TextEditingController();
  final _descripcionEmprendimientoController = TextEditingController();

  String? _opcionSeleccionada;

  void _registrarUsuario() {
    String nombre = _nombreController.text;
    String correo = _correoController.text;
    String contrasena = _contrasenaController.text;

    // Solo para fines de demostración, imprime los datos en la consola
    print("Nombre: $nombre");
    print("Correo: $correo");
    print("Contraseña: $contrasena");
    print("Opción seleccionada: $_opcionSeleccionada");
    if (_opcionSeleccionada == "unir") {
      print("Código de acceso: ${_codigoAccesoController.text}");
    } else if (_opcionSeleccionada == "crear") {
      print(
          "Nombre del emprendimiento: ${_nombreEmprendimientoController.text}");
      print(
          "Descripción del emprendimiento: ${_descripcionEmprendimientoController.text}");
    }
  }

  void _mostrarModalOpciones() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Crear emprendimiento"),
              onTap: () {
                setState(() {
                  _opcionSeleccionada = "crear";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Unirse a un emprendimiento"),
              onTap: () {
                setState(() {
                  _opcionSeleccionada = "unir";
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _correoController,
                  decoration:
                      const InputDecoration(labelText: 'Correo Electrónico'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _contrasenaController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _mostrarModalOpciones,
                  child: const Text('Unirse/Crear Emprendimiento'),
                ),
                // Mostrar campos adicionales según la opción seleccionada
                if (_opcionSeleccionada == "unir") ...[
                  const SizedBox(height: 20),
                  TextField(
                    controller: _codigoAccesoController,
                    decoration:
                        const InputDecoration(labelText: 'Código de Acceso'),
                  ),
                ] else if (_opcionSeleccionada == "crear") ...[
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nombreEmprendimientoController,
                    decoration: const InputDecoration(
                        labelText: 'Nombre del Emprendimiento'),
                  ),
                  TextField(
                    controller: _descripcionEmprendimientoController,
                    decoration: const InputDecoration(
                        labelText: 'Descripción del Emprendimiento'),
                  ),
                ],
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _opcionSeleccionada == null ? null : _registrarUsuario,
          child: const Text('Registrar'),
        ),
      ),
    );
  }
}
