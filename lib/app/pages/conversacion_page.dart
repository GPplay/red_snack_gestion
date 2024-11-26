import 'package:flutter/material.dart';

class ConversacionPage extends StatefulWidget {
  final String nombre; // Recibe el nombre desde la pantalla anterior

  const ConversacionPage({super.key, required this.nombre});

  @override
  State<ConversacionPage> createState() => _ConversacionPageState();
}

class _ConversacionPageState extends State<ConversacionPage> {
  final TextEditingController _messageController = TextEditingController();
  bool isTyping = false; // Controla si el usuario está escribiendo

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      // Verifica si el usuario ha empezado a escribir
      setState(() {
        isTyping = _messageController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.yellow,
              child: Icon(Icons.person, color: Colors.black),
            ),
            const SizedBox(width: 10),
            Text(widget.nombre,
                style: const TextStyle(
                    color: Colors
                        .white)), // Muestra el nombre en la barra superior
          ],
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                // Mensaje recibido
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.yellow,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Text('Hola'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Mensaje enviado
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Hola',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.purpleAccent,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Caja de texto y botón de envío
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.emoji_emotions_outlined),
                      hintText: 'Mensaje',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    if (isTyping) {
                      // Lógica para enviar mensaje
                      // ignore: avoid_print
                      print("Mensaje enviado: ${_messageController.text}");
                      _messageController
                          .clear(); // Limpiar el campo después de enviar
                    } else {
                      // Lógica para activar el micrófono o grabar
                      // ignore: avoid_print
                      print("Grabar audio");
                    }
                  },
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.send), // Cambia entre mic y enviar
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
