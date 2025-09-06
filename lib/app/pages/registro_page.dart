// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:red_snack_gestion/app/services/api_services.dart';
import 'package:red_snack_gestion/app/widget/campo_texto.dart';
import 'package:red_snack_gestion/app/widget/campos_adicionales.dart';
import 'package:red_snack_gestion/app/widget/modal.dart';

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _codigoAccesoController = TextEditingController();
  final _nombreEmprendimientoController = TextEditingController();
  final _descripcionEmprendimientoController = TextEditingController();

  String? _opcionSeleccionada;

  final ApiService apiService = ApiService();
  bool loading = false;

  void _registrarUsuario() async {
    setState(() => loading = true);

    final result = await apiService.registerUser(
      nombre: _nombreController.text,
      email: _correoController.text,
      password: _contrasenaController.text,
      emprendimientoId:
          _opcionSeleccionada == "unir" ? _codigoAccesoController.text : null,
      nombreEmprendimiento: _opcionSeleccionada == "crear"
          ? _nombreEmprendimientoController.text
          : null,
      descripcionEmprendimiento: _opcionSeleccionada == "crear"
          ? _descripcionEmprendimientoController.text
          : null,
    );

    setState(() => loading = false);

    if (result.success) {
      // Registro correcto → regresar al login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuario creado correctamente")),
      );
      Navigator.pop(context); // vuelve a la pantalla de login
    } else {
      // Mostrar error de la API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message)),
      );
    }
  }

  void _mostrarModalOpciones() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ModalOpciones(
        onSelect: (opcion) {
          setState(() => _opcionSeleccionada = opcion);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CampoTexto(controller: _nombreController, label: 'Nombre'),
                CampoTexto(
                    controller: _correoController,
                    label: 'Correo Electrónico',
                    keyboard: TextInputType.emailAddress),
                CampoTexto(
                    controller: _contrasenaController,
                    label: 'Contraseña',
                    obscure: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _mostrarModalOpciones,
                  child: const Text('Unirse/Crear Emprendimiento'),
                ),
                CamposAdicionales(
                  opcion: _opcionSeleccionada,
                  codigoAccesoController: _codigoAccesoController,
                  nombreEmprendimientoController:
                      _nombreEmprendimientoController,
                  descripcionEmprendimientoController:
                      _descripcionEmprendimientoController,
                ),
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
          child: loading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Registrar'),
        ),
      ),
    );
  }
}
