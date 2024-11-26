import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/conversacion_page.dart'; // Importar la nueva página de conversación
import 'package:red_snack_gestion/app/widget/appbar.dart';

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
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[300],
                  child:
                      const Icon(Icons.person, size: 30, color: Colors.black),
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
