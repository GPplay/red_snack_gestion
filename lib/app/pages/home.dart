import 'package:flutter/material.dart';  
import 'package:red_snack_gestion/app/pages/chat_page.dart';  
import 'package:red_snack_gestion/app/widget/appbar.dart';  
import 'package:red_snack_gestion/app/widget/grafica.dart'; // Biblioteca para gráficos de barras  

class HomeScreen extends StatelessWidget {  
  const HomeScreen({super.key});  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: const GlobalAppBar(title: 'Home', chatPage: Chats()),   
      drawer: const SideMenu(),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.center,  
          children: [  
            // Usa Expanded o Flexible para el gráfico  
            const Expanded(  
              child: TransaccionesEstado(),  
            ),  
            const SizedBox(height: 5),  
            // Tarjetas con ventas, gastos, ganancias  
            _buildInfoCard('Ventas:'),  
            const SizedBox(height: 10),  
            _buildInfoCard('Gastos: '),  
            const SizedBox(height: 10),  
            _buildInfoCard('Ganancias: '),  
          ],  
        ),  
      ),  
      floatingActionButton: FloatingActionButton(  
        onPressed: () {  
          // Acción para agregar nueva venta o registro  
        },  
        // ignore: sort_child_properties_last  
        child: const Icon(Icons.add),  
        backgroundColor: Colors.red,  
      ),  
    );  
  }  

  // Método para construir las tarjetas de información  
  Widget _buildInfoCard(String text) {  
    return Container(  
      padding: const EdgeInsets.all(16.0),  
      width: double.infinity,  
      decoration: BoxDecoration(  
        color: Colors.white,  
        borderRadius: BorderRadius.circular(20),  
        border: Border.all(color: Colors.grey.shade300),  
      ),  
      child: Text(  
        text,  
        style: const TextStyle(  
          fontSize: 18,  
          fontWeight: FontWeight.w500,  
        ),  
      ),  
    );  
  }  
}