import 'dart:async';
import 'package:carnaval/addons/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart'; // Para obtener la ubicación
import '../services/DatabaseHelper.dart';
import 'package:intl/intl.dart'; // Asegúrate de tener esta importación

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSendingLocation = false; // Estado para verificar si se está enviando la ubicación
  Timer? _timer;
  bool _backgroundStatus = false;
  @override
  void initState() {
    super.initState();
    // showNotification('Bienvenido a la aplicación de Carnaval Oruro', 0);
    _statusBackGround();
  }
  _statusBackGround() async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (isRunning) {
      _backgroundStatus = true;
    }else{
      _backgroundStatus = false;
    }
    setState(() {});
  }
  _backGround() async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService");
      _backgroundStatus = false;
    }else {
      service.startService();
      _backgroundStatus = true;
    }
    setState(() {
      _backgroundStatus = _backgroundStatus;
    });
  }

  // void _toggleLocationSending() async {
  //   if (_isSendingLocation) {
  //     // Si ya se está enviando, detener el envío
  //     setState(() {
  //       _isSendingLocation = false;
  //     });
  //     _timer?.cancel(); // Detiene el temporizador
  //   } else {
  //     // Inicia el envío de ubicación cada 5 segundos
  //     setState(() {
  //       _isSendingLocation = true;
  //     });
  //     _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
  //       await _sendLocation();
  //     });
  //   }
  // }


  Future<void> _sendLocation() async {
    try {
      // Obtiene la ubicación actual
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // Obtiene la hora actual con segundos
      String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

      // Muestra una notificación con la hora y coordenadas
      showNotification('Enviando ubicación: $currentTime', 1);

      // Envía la ubicación a la base de datos
      await DatabaseHelper().sendLocation(position.latitude, position.longitude);

    } catch (e) {
      print('Error obteniendo la ubicación: $e');
      showNotification('Error obteniendo la ubicación', 1);
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador al salir
    super.dispose();
  }

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
              onPressed: _backGround,
              style: ElevatedButton.styleFrom(
                backgroundColor: _backgroundStatus ? Colors.red : Colors.green, // Cambia el color
                foregroundColor: Colors.white, // Cambia el color del texto
              ),
              child: Text(_backgroundStatus ? 'Enviando' : 'Mandar ubicación',style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper().logout();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
