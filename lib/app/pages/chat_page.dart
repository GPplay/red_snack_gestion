import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/conversacion_page.dart';
import 'package:red_snack_gestion/app/widget/appbar.dart';
import 'package:red_snack_gestion/app/widget/mixin.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatState();
}

class _ChatState extends State<Chats> with RefreshableMixin {
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
      body: RefreshIndicator(
        onRefresh: refreshData, // usamos el mixin
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.person,
                              size: 30, color: Colors.black),
                        ),
                        title: Text(
                          names[index],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ConversacionPage(nombre: names[index]),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 2, color: Colors.grey),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
