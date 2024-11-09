import 'package:flutter/material.dart';
import '../services/DatabaseHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carnaval Oruro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido a la aplicación de Carnaval Oruro'),
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper().logout(); // Asegúrate de esperar a que se complete
                Navigator.pushReplacementNamed(context, '/'); // Redirige a la pantalla de inicio de sesión
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
