import 'package:carnaval/pages/login.dart';
import 'package:carnaval/pages/home.dart'; // Importa tu página de inicio
import 'package:carnaval/services/DatabaseHelper.dart';
import 'package:flutter/material.dart';

import 'addons/scaffold.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  await dotenv.load(fileName: isProduction ? ".env.production" : ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carnaval Oruro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define rutas de navegación
      routes: {
        '/': (context) => LoginPage(),      // Página de inicio de sesión
        '/home': (context) => HomePage(),    // Página de inicio o principal
      },
      initialRoute: '/', // Ruta inicial
    );
  }
}
