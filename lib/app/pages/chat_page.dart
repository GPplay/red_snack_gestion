import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/conversacion_page.dart'; // Importar la nueva página de conversación
import 'package:red_snack_gestion/app/widget/appbar.dart';
import 'package:red_snack_gestion/app/widget/perfil.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatState();
}

class _ChatState extends State<Chats> {
  final List<String> names = [
    'Nombre 1',
    'Nombre 2',
    'Nombre 3',
    'Nombre 4',
    'Nombre 5',
    'Nombre 6',
    'Nombre 7',
    'Nombre 8',
    'Nombre 9',
    'Nombre 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Chats', chatPage: Chats()),
      drawer: const SideMenu(),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: ImagenPerfil(
                  backgroundColor: Colors.blue[100] ?? Colors.blue,
                  iconColor: Colors.blue,
                  textColor: Colors.blue[900] ?? Colors.blue,
                ),
                title: Text(
                  names[index],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  // Navegar a la página de conversación cuando se haga clic
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ConversacionPage(nombre: names[index]),
                    ),
                  );
                },
              ),
              const Divider(height: 1, color: Colors.grey),
            ],
          );
        },
      ),
    );
  }
}
