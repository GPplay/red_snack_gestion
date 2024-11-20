import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/models/usuario.dart';

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
  final _idEmprendimiento = TextEditingController();
  final _nombreEmprendimientoController = TextEditingController();
  final _descripcionEmprendimientoController = TextEditingController();

  String? _opcionSeleccionada;

  void _registrarUsuario() {
    String nombre = _nombreController.text;
    String correo = _correoController.text;
    String contrasena = _contrasenaController.text;
    int idEmprendimientoValue = _idEmprendimiento.hashCode;

    Usuario nuevoUsuario = Usuario(
      nombre: nombre,
      correo: correo,
      contrasena: contrasena,
      idEmprendimiento: idEmprendimientoValue,
    );

    // ignore: avoid_print
    print(nuevoUsuario.toJson());
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
                if (_opcionSeleccionada == "unirse") ...[
                  TextField(
                    controller: _idEmprendimiento,
                    decoration: const InputDecoration(
                        labelText: 'Agregar ID Emprendimiento'),
                  ),
                ] else if (_opcionSeleccionada == "crear") ...[
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
