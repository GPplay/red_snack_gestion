import 'package:flutter/material.dart';

class FormularioDinamico {
  /// Método para mostrar el formulario dinámico
  static Future<Map<String, dynamic>?> mostrarFormulario({
    required BuildContext context,
    required String titulo,
    required List<Map<String, dynamic>> preguntas,
    String textoBoton = 'Guardar',
    Color colorBoton = Colors.red,
    Color colorFondo = Colors.white,
    Color colorTitulo = Colors.black,
    Color colorTextoCampos = Colors.black, //personalizar color de texto
    Color colorTextoBoton =
        Colors.white, //personalizar color de texto del boton
  }) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Map<String, dynamic> valores = {};

    return await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: colorFondo,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título
                  Text(
                    titulo,
                    style: TextStyle(
                      color: colorTitulo,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Preguntas dinámicas
                  ...preguntas.map((pregunta) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: pregunta['label'] ?? 'Pregunta',
                          labelStyle: TextStyle(
                              color:
                                  colorTextoCampos), // Aplica color a las etiquetas
                          border: const OutlineInputBorder(),
                          hintText: pregunta['hint'] ?? '',
                          // ignore: deprecated_member_use
                          hintStyle: TextStyle(
                              // ignore: deprecated_member_use
                              color: colorTextoCampos.withOpacity(
                                  0.6)), // Aplica color a los hints
                        ),
                        keyboardType: pregunta['tipo'] ?? TextInputType.text,
                        style: TextStyle(
                            color:
                                colorTextoCampos), // Aplica color al texto ingresado
                        initialValue:
                            pregunta['valorInicial']?.toString() ?? '',
                        validator: pregunta['validacion'],
                        onSaved: (nuevoValor) {
                          valores[pregunta['nombre']] = nuevoValor;
                        },
                      ),
                    );
                  }).toList(),
                  // Botón
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Navigator.of(context)
                            .pop(valores); // Devuelve los valores
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorBoton,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      textoBoton,
                      style: TextStyle(color: colorTextoBoton),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
