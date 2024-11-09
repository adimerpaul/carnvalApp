import 'package:flutter/material.dart';

import 'addons/scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  bool _isCodeVisible = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // print("Inicio de sesión exitoso!");
      success(context, 'Inicio de sesión exitoso!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login Page'),
      // ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/logofull.png',
                  height: 100,
                ),
                SizedBox(height: 20),
                // Campo de código de 4 dígitos
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: 'Código de 4 dígitos',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isCodeVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isCodeVisible = !_isCodeVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isCodeVisible,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el código';
                    }
                    if (value.length != 4 || !RegExp(r'^\d{4}$').hasMatch(value)) {
                      return 'El código debe tener exactamente 4 dígitos';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // Botón de inicio de sesión
                ElevatedButton(
                  onPressed: _login,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                    child: Text('Ingresar', style: TextStyle(fontSize: 18)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blueAccent, // Cambiado a un tono más intenso
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                // Enlace para crear cuenta
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Nuevo Usuario? "),
                    GestureDetector(
                      onTap: () {
                        // Navegar a la página de registro
                      },
                      child: Text(
                        "Crear cuenta",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
