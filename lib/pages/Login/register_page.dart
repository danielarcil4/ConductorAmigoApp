import 'package:conductor_amigo/pages/chat/auth_service.dart';
import 'package:conductor_amigo/pages/ConductorAmigo/conductor_amigo_page.dart';
import 'package:conductor_amigo/pages/Login/login_page.dart';
import 'package:conductor_amigo/pages/usuarioAmigo/usuario_comun_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _identificacionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatpasswordController = TextEditingController();

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
      isName = false,
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
        } else if (isName) {
          if(value!.isEmpty) {
            return 'Por favor, ingresa un nombre de usuario';
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
          }else {
            return null;
          }
        }
        return null;
      },
    );
  }

  Widget _buildElevatedButton(
    int colorButton,
    String text,
    bool registrarUsuario,
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: () {
        if (registrarUsuario) {
          if (_formKey.currentState!.validate()) {
            signUp(context);
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

  void signUp(BuildContext context) async {
    final _auth = AuthService();
    try {
      await _auth.signUpWithEmailPassword(
        _emailController.text,
        _passwordController.text,
        dropdownValue!,  // Pass the role here}
        _userNameController.text,
        _identificacionController.text,
      );
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage())
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
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
                            _userNameController, "Nombre de Usuario", isName: true),
                        _buildInputField(
                            _identificacionController, "Identificacion",
                            isOnlyNumbers: true),
                        _buildInputField(
                            _emailController, "Correo Institucional",
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
                          items: <String>['Usuario Común', 'Conductor Amigo']
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
                            labelText: 'Elija su rol',
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
                              return 'Elija su rol'; // Mensaje de error si no
                              // se selecciona ninguna opción
                            }
                            return null; // Retorna null si la validación es
                            // exitosa
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
                              const SizedBox(height: 20),
                              _buildInputField(_modeloController,
                                  "Ingrese el modelo de su vehículo",
                                  isModelo: true),
                              const SizedBox(height: 20),
                              _buildInputField(_placaController,
                                  "Ingrese la placa de su vehículo",
                                  isPlaca: true),
                              const SizedBox(height: 20),
                              _buildInputField(_colorController,
                                  "Ingrese el color de su vehículo",
                                  isColor: true),
                              const SizedBox(height: 20),
                            ],
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
                  _buildElevatedButton(
                      0xFF7DB006, "REGISTRARSE", true, context),
                  const SizedBox(height: 20),
                  _buildElevatedButton(0xFFC74A4D, "SALIR", false, context),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ConductorAmigoPage()));
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
                      'Ingresar como admin a conductor amigo',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UsuarioComunPage()));
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
                      'Ingresar como admin a usuario',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
