import 'package:conductor_amigo/pages/auth_service.dart';
import 'package:conductor_amigo/pages/register_page.dart';
import 'package:conductor_amigo/pages/usuario_comun_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorTextEmail = '';
  String errorTextPassword = '';
  final RegExp _emailRegExp = RegExp(r'^[\w-\.]+@udea.edu.co',);

  Widget _buildInputField(TextEditingController controller, String labelName,
      {bool isPassword = false, String? errorText}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelName,
        errorText: errorText,
        labelStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w300),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white70,
              width: 3),
        ),
      ),
      obscureText: isPassword,
      validator: (value) {
        if (isPassword) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa tu contraseña';
          } else if (value.length < 6) {
            return 'La contraseña debe tener al menos 6 caracteres';
          }
          return null;
        } else {
          if (value!.isEmpty) {
            return 'Por favor, ingresa tu correo';
          }
          else if (!value.contains("@udea.edu.co")) {
            return 'Por favor, introduce un correo del dominio @udea.edu.co';
          }
          else if (!_emailRegExp.hasMatch(value)) {
            return 'Por favor, introduce un correo electrónico válido';
          }
          return null;
        }
      },
    );
  }

  Widget _buildElevatedButton(int colorButton, String text) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          login(context);
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color(colorButton),
        elevation: 20,
        shadowColor: const Color(0xFF14612C),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  void login(BuildContext context) async{

    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(_emailController.text, _passwordController.text);
      Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => const UsuarioComunPage()),
           );
    }
    
    catch (e){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
      );
    }
    // Aquí puedes realizar las acciones necesarias para iniciar sesión,
    // como por ejemplo, autenticar al usuario utilizando Firebase Auth
    // y luego navegar a la página correspondiente.
    // Ejemplo:
    // try {
    //   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //   );
    //   _emailController.clear();
    //   _passwordController.clear();
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const UsuarioComunPage()),
    //   );
    // } on FirebaseAuthException catch (e) {
    //   // Manejar posibles errores de autenticación aquí
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7DB006),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'lib/asset/image/ConductorAmigoLogo.png',
                  fit: BoxFit.contain,
                  width: 160,
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildInputField(
                              _emailController,
                              'Usuario o correo electrónico',
                              errorText: errorTextEmail
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          _buildInputField(
                              _passwordController,
                              'Contraseña',
                              isPassword: true,
                              errorText: errorTextPassword
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          _buildElevatedButton(0xFF14612C, 'INGRESAR'),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1.2,
                        color: Colors.white,
                        endIndent: 20,
                      ),
                    ),
                    Text(
                      'O',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w300),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1.2,
                        color: Colors.white,
                        indent: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  icon: const Icon(
                    Icons.mail_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xFFC2C8CF),
                      elevation: 20,
                      shadowColor: const Color(0xFF14612C),
                      minimumSize: const Size.fromHeight(50)),
                  label: const Text(
                    'INGRESAR CON GOOGLE',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(height: 64),
                Image.asset(
                  'lib/asset/image/UdeaLogo.png',
                  fit: BoxFit.contain,
                  width: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
