import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:votacionesappg14/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void registerWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
    }
    try {
      User? user = await AuthService.registerWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
        context,
      );
    } catch (e) {
      print("ERROR: $e");
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  Widget _builField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isPassoword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.orange,
        style: TextStyle(fontWeight: FontWeight.bold),
        obscureText: isPassoword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2),
          ),
        ),
        keyboardType: isPassoword
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,

        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor ingresa $label";
          }
          if (label == "Correo electrónico" &&
              !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Por favor ingresa un correo válido';
          }
          if (label == "Contraseña" && value.length < 6) {
            return "La contraseña debe tener al menos 6 caracteres";
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff173D31), Colors.white],
                        stops: [0.5, 0.5],
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  height: 145,
                                  width: size.width,
                                  color: Color(0xff173D31),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.amber,
                                        ),
                                        child: Icon(Icons.arrow_back),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        "Crear cuenta",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            height: size.height - 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _builField(
                                  controller: _nameController,
                                  label: "Nombre",
                                  hint: "Ingresa tu nombre",
                                ),
                                _builField(
                                  controller: _emailController,
                                  label: "Correo",
                                  hint: "Ingrsa tu correo",
                                ),
                                _builField(
                                  controller: _passwordController,
                                  label: "Contraseña",
                                  hint: "Ingresa tu contraseña",
                                  isPassoword: true,
                                ),
                                _builField(
                                  controller: _phoneController,
                                  label: "Teléfono",
                                  hint: "Ingresa tu número de contacto",
                                ),
                                _builField(
                                  controller: _addressController,
                                  label: "Dirección",
                                  hint: "Ingresa dónde vives",
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 32,
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 60,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff173D31),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        registerWithEmailAndPassword();
                                      },
                                      child: Text("Regístrate"),
                                    ),
                                  ),
                                ),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     AuthService.loginWithEmailAndPassword(
                                //       _emailController.text,
                                //       _passwordController.text,
                                //       context,
                                //     );
                                //   },
                                //   child: Text("Iniciar sesión "),
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Si ya tiene una cuenta"),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text("Inicia sesión"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
