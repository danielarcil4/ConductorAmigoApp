import 'package:conductor_amigo/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _identificacionController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatpasswordController =
      TextEditingController();
  String? dropdownValue;
  final _formKey = GlobalKey<FormState>();
  String errorTextEmail = '';
  bool isVisiblePassword = false;

  // Expresión regular para validar la estructura del correo electrónico
  final RegExp _emailRegExp = RegExp(
    r'^[\w-]+@udea.edu.co',
  );

  Widget _buildInputField(TextEditingController controller, String labelName,
      {isPassword = false, isOnlyNumbers = false,errorText}) {
    return TextFormField(
      controller: controller,
      keyboardType: isOnlyNumbers ? TextInputType.number : TextInputType.text,
      inputFormatters: isOnlyNumbers
          ? [FilteringTextInputFormatter.digitsOnly]
          : [FilteringTextInputFormatter.singleLineFormatter],
      decoration:  InputDecoration(
        errorText: errorTextEmail == '' ? null : errorText,
        suffixIcon: IconButton(
          onPressed: () {
            setState((){
                isVisiblePassword = !isVisiblePassword;
              }
            );
        }, icon: Icon(!isPassword? Icons.edit :
        isVisiblePassword? Icons.visibility : Icons.visibility_off
          ),
        ),
        labelText: labelName,
        labelStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w400),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 2), // Cambia el color de resaltado aquí
        ),
      ),
      obscureText: isPassword? !isVisiblePassword:false,
      validator: (value) {
        if (isPassword) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa tu contraseña';
          } else if (value.length < 6) {
            return 'La contraseña debe tener al menos 6 caracteres';
          }else if(_passwordController.text!=_repeatpasswordController.text){
            return 'Las contraseñas no son iguales';
          }
          return null;
        } else if (isOnlyNumbers) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa tu identificacion';
          } else if (value.length < 6) {
            return 'La identificacion debe tener al menos 6 caracteres';
          }
        } else {
          if (value!.isEmpty) {
            return 'Por favor, ingresa tu correo';
          } else if (!value.contains("@udea.edu.co")) {
            return 'Por favor, introduce un correo del dominio\n '
                    '@udea.edu.co';
          } else if (!_emailRegExp.hasMatch(value)) {
            return 'Por favor, introduce un correo electrónico válido';
          }else if(errorTextEmail == ''){
            return 'Si';
          }
          return null;
        }
        return null;
      },
    );
  }

  Widget _buildElevatedButton(
      int colorButton, String text, bool registrarUsuario, BuildContext context,) {
    return ElevatedButton(
      onPressed: ()  {
        if (registrarUsuario) {
          if (_formKey.currentState!.validate()) {
            signUp();
          }
        } else {
          _mostrarMensaje(context);
        }
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Color(colorButton),
          elevation: 20,
          shadowColor: const Color(0xFF14612C),
          minimumSize: const Size.fromHeight(50)),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w300),
      ),
    );
  }

  void _mostrarMensaje(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Construye el cuadro de diálogo personalizado
        return AlertDialog(
            title: const Text(
              'Ya casi está...\n'
              '¿Estás segur@?',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'El proceso de registro es\n'
                  'indispensble para que puedas\n'
                  'iniciar en la platarforma y\n'
                  'empezar a contactarte con tu\n'
                  'Conductor Amigo. ',
                  style: TextStyle(
                      fontFamily: 'Ubuntu', fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Cerrar el cuadro de diálogo
                        // Agregar aquí la lógica para salir de la aplicación
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'CANCELAR',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text(
                        'SALIR',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.white);
      },
    );
  }

  Future<void> signUp() async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginPage()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorTextEmail = 'Este correo ya esta registrado';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              height: 150,
              alignment: Alignment.center,
              color: const Color(0xFF14612C),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "¡Regístrate!",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400,
                              fontSize: 30),
                        ),
                        Text(
                          "Aquí puedes crear tu nueva cuenta",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                        )
                      ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 64),
              child: Column(
                children: [
                  const Text(
                    "Queremos conocerte, ingresa tus datos:",
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildInputField(
                            _identificacionController, "Identificacion",
                            isOnlyNumbers: true),
                        _buildInputField(
                            _emailController, "Correo Institucional",errorText: errorTextEmail),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 35,
                          ),
                          elevation: 16,
                          isExpanded: true,
                          itemHeight: 60,
                          style: const TextStyle(color: Colors.black),
                          items: <String>[
                            'Usuario Común',
                            'Conductor Amigo'
                            ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            labelText: 'Elija su rol',
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2), // Cambia el color de resaltado aquí
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Elija su rol'; // Mensaje de error si no se selecciona ninguna opción
                            }
                            return null; // Retorna null si la validación es exitosa
                          },
                          onChanged: (String? value) {
                            dropdownValue = value!;
                          },
                        ),
                        _buildInputField(_passwordController, "Contraseña",
                            isPassword: true),
                        _buildInputField(
                            _repeatpasswordController, "Repetir Contraseña",
                            isPassword: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 130),
                  _buildElevatedButton(0xFF7DB006, "REGISTRARSE", true, context),
                  const SizedBox(height: 20),
                  _buildElevatedButton(0xFFC74A4D, "SALIR", false, context),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
