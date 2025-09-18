import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/widget/campo_texto.dart';


class CamposAdicionales extends StatelessWidget {
  final String? opcion;
  final TextEditingController codigoAccesoController;
  final TextEditingController nombreEmprendimientoController;
  final TextEditingController descripcionEmprendimientoController;

  const CamposAdicionales({super.key, 
    required this.opcion,
    required this.codigoAccesoController,
    required this.nombreEmprendimientoController,
    required this.descripcionEmprendimientoController,
  });

  @override
  Widget build(BuildContext context) {
    if (opcion == "unir") {
      return CampoTexto(controller: codigoAccesoController, label: "Código de Acceso");
    } else if (opcion == "crear") {
      return Column(
        children: [
          CampoTexto(controller: nombreEmprendimientoController, label: "Nombre del Emprendimiento"),
          CampoTexto(controller: descripcionEmprendimientoController, label: "Descripción del Emprendimiento"),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}