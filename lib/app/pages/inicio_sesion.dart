import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/home.dart';
import 'package:red_snack_gestion/app/pages/registro_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Bienvenido a Red Snack gestion',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Aquí va la lógica de inicio de sesión
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              // ignore: sort_child_properties_last
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Navegar a la pantalla de registro
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistroUsuario()));
              },
              child: Text(
                '¿No tienes una cuenta? Regístrate',
                style: TextStyle(color: Colors.red[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
