import 'package:flutter/material.dart';
import 'package:red_snack_gestion/app/pages/home.dart';
import 'package:red_snack_gestion/app/pages/inicio_sesion.dart';
import 'package:red_snack_gestion/app/pages/inventario_page.dart';
import 'package:red_snack_gestion/app/pages/historial_venta_page.dart';
import 'package:red_snack_gestion/app/pages/usuario_page.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget chatPage;

  const GlobalAppBar({
    super.key,
    required this.title,
    required this.chatPage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => chatPage),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.red,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Opciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawerItem('Inicio', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }),
            _buildDrawerItem('Inventario', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InventarioScreen()),
              );
            }),
            _buildDrawerItem('Historial de ventas', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HistorialVentas()),
              );
            }),
            _buildDrawerItem('Perfil', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsuarioPage()),
              );
            }),
            const SizedBox(height: 100), // Espacio extra
            _buildDrawerItem('Cerrar sesión', () {
              // Accion para cerrar sesión
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }, isLogout: true),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para crear cada opción del menú
  Widget _buildDrawerItem(String text, VoidCallback onTap,
      {bool isLogout = false}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onTap: onTap,
      // ignore: deprecated_member_use
      tileColor: isLogout ? Colors.white.withOpacity(0.1) : Colors.transparent,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
