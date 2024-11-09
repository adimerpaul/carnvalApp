import 'package:flutter/material.dart';

void successfulLogin(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Inicio de sesión exitoso!'),
      backgroundColor: Colors.green,
    ),
  );
}