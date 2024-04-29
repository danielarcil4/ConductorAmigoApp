import 'package:conductor_amigo/pages/ConductorAmigo/conductor_amigo_page.dart';
import 'package:conductor_amigo/pages/Login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _identificacionController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatpasswordController =
      TextEditingController();

  String? dropdownValue;
  bool showAdditionalOptions = false;

  final _formKey = GlobalKey<FormState>();
  String errorTextEmail = '';
  bool isVisiblePassword = false;

  // Expresión regular para validar la estructura del correo electrónico
  final RegExp _emailRegExp = RegExp(
    r'^[\w-]+@udea.edu.co',
  );

  final RegExp _validatePlaca = RegExp(
    // Expresión regular para validar el formato de la placa
    r'^[A-Z]{3}\s?\d{3}$',
    caseSensitive: false,
  );

  Widget _buildInputField(TextEditingController controller, String labelName,
      {isPassword = false,
      isOnlyNumbers = false,
      isModelo = false,
      isPlaca = false,
      isColor = false,
      errorText}) {
    return TextFormField(
      controller: controller,
      keyboardType: isOnlyNumbers ? TextInputType.number : TextInputType.text,
      inputFormatters: isOnlyNumbers
          ? [FilteringTextInputFormatter.digitsOnly]
          : [FilteringTextInputFormatter.singleLineFormatter],
      decoration: InputDecoration(
        errorText: errorTextEmail == '' ? null : errorText,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              if (!isPassword) {
                isPassword = !isPassword;
              } else {
                // Toggle visibility icon
                isVisiblePassword = !isVisiblePassword;
              }
            });
          },
          icon: Icon(!isPassword
              ? Icons.edit
              : isVisiblePassword
                  ? Icons.visibility
                  : Icons.visibility_off),
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
      obscureText: isPassword ? !isVisiblePassword : false,
      validator: (value) {
        if (isPassword) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa tu contraseña';
          } else if (value.length < 6) {
            return 'La contraseña debe tener al menos 6 caracteres';
          } else if (_passwordController.text !=
              _repeatpasswordController.text) {
            return 'Las contraseñas no son iguales';
          }
          return null;
        } else if (isOnlyNumbers) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa tu identificacion';
          } else if (value.length < 6) {
            return 'La identificacion debe tener al menos 6 caracteres';
          }
        } else if (isModelo) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa el modelo del vehículo';
          } else {
            return null;
          }
        } else if (isPlaca) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa la placa del vehículo';
          } else if (!_validatePlaca.hasMatch(value)) {
            return 'Por favor, introduce una placa válida';
          }
          return null;
        } else if (isColor) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa el color del vehículo';
          } else {
            return null;
          }
        } else {
          if (value!.isEmpty) {
            return 'Por favor, ingresa tu correo';
          } else if (!value.contains("@udea.edu.co")) {
            return 'Por favor, introduce un correo del dominio\n '
                '@udea.edu.co';
          } else if (!_emailRegExp.hasMatch(value)) {
            return 'Por favor, introduce un correo electrónico válido';
          } else if (errorTextEmail == '') {
            return 'Si';
          }
          else {
            return null;
          }
        }
        return null;
      },
    );
  }

  Widget _buildElevatedButton(int colorButton, String text,
      bool registrarUsuario, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
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
                  'Eliminarás permanentemente\n'
                  'tu viaje programado.\n'
                  'Recuerda que serás penalizado\n'
                  'si eliminas tu viaje a 2 horas o\n'
                  'menos antes de la hora de\n'
                  'salida',
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
                        'REGRESAR',
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
                                builder: (context) =>
                                    const ConductorAmigoPage()));
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text(
                        'ELIMINAR',
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
                          "Edita tu viaje",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400,
                              fontSize: 30),
                        ),
                        Text(
                          "Cambia los detalles de tus viajes programados",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        )
                      ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 64),
              child: Column(
                children: [
                  const Text(
                    "¡Recuerda que tus viajes programados reservados por "
                    "Usuarios Amigos no pueden ser modificados!",
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildInputField(
                            _identificacionController, "Punto de Recogida",
                            isOnlyNumbers: false),
                        _buildInputField(_emailController, "Lugar de Destino",
                            errorText: errorTextEmail),
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
                          items: <String>['1', '2', '3', '4']
                              .map<DropdownMenuItem<String>>((String value) {
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
                            labelText: 'Número de Pasajeros',
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width:
                                      2), // Cambia el color de resaltado aquí
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Elija el número de pasajeros disponibles'; // Mensaje de er
                              // ror si no se selecciona ninguna opción
                            }
                            return null; // Retorna null si la validación es exitosa
                          },
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value;
                              if (value == 'Conductor Amigo') {
                                showAdditionalOptions = true;
                              } else {
                                showAdditionalOptions = false;
                              }
                            });
                          },
                        ),
                        if (showAdditionalOptions)
                          Column(
                            children: [
                              _buildInputField(_modeloController,
                                  "Ingrese el modelo de su vehículo",
                                  isModelo: true),
                              _buildInputField(_placaController,
                                  "Ingrese la placa de su vehículo",
                                  isPlaca: true),
                              _buildInputField(_colorController,
                                  "Ingrese el color de su vehículo",
                                  isColor: true),
                            ],
                          ),
                        _buildInputField(
                            _passwordController, "Valor del servicio",
                            isOnlyNumbers: true, isPassword: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 130),
                  _buildElevatedButton(
                      0xFF7DB006, "GUARDAR CAMBIOS", true, context),
                  const SizedBox(height: 20),
                  _buildElevatedButton(
                      0xFFC74A4D, "ELIMINAR VIAJE", false, context),
                  const SizedBox(height: 20),
                  _buildElevatedButton(0x809E9E9E, "CANCELAR", false, context),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
