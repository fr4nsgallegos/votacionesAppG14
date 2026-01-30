import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:votacionesappg14/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  void registerWithEmailAndPassword() async {
    try {
      User? user = await AuthService.registerWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
        context,
      );
    } catch (e) {
      print("ERROR: $e");
    }
  }

  Widget _builField(
    TextEditingController controller,
    String label,
    String hint,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _builField(_nameController, "Nombre", "Ingresa tu nombre"),
              _builField(_emailController, "Correo", "Ingrsa tu correo"),
              _builField(
                _passwordController,
                "Contraseña",
                "Ingresa tu contraseña",
              ),
              _builField(
                _phoneController,
                "Teléfono",
                "Ingresa tu número de contacto",
              ),

              _builField(
                _addressController,
                "Dirección",
                "Ingresa dónde vives",
              ),

              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  registerWithEmailAndPassword();
                },
                child: Text("Regístrate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
