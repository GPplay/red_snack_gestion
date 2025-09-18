import 'package:flutter/material.dart';

// Este mixin proporciona un estado de carga y una función para simular la recarga de datos.
// Se puede reutilizar en cualquier StatefulWidget.
mixin RefreshableMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  // Usa un Future para simular la recarga de datos.
  // Debes reemplazar esta función en cada clase que use el mixin
  // para realizar la recarga real de la información (ej. llamadas a APIs).
  Future<void> refreshData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulación de una llamada asíncrona a la API.
    // Reemplaza esta línea con tu lógica para obtener datos.
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  // Getter para el estado de carga.
  // Permite a los widgets verificar si la recarga está en curso.
  bool get isLoading => _isLoading;
}
