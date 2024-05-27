import 'package:conductor_amigo/models/conductor_amigo_user.dart';
import 'package:flutter/material.dart';

import '../../models/provider_user.dart';
import '../Login/login_page.dart';

class PerfilConductorPage extends StatefulWidget {
  const PerfilConductorPage({super.key});

  @override
  State<PerfilConductorPage> createState() => _PerfilConductorPageState();
}

class _PerfilConductorPageState extends State<PerfilConductorPage> {

  Widget _buildElevatedButton(int colorButton, String text, bool cerrarSesion) {
    return ElevatedButton(
      onPressed: ()  {
        if (cerrarSesion) {
          _mensajeCerrarSesion(context);
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

  void _mensajeCerrarSesion(BuildContext context) {
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
                  '¿Qué quieres Cerrar Sesion?',
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
                                builder: (context) => const LoginPage()));
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text(
                        'Cerrar Sesion',
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

  @override
  Widget build(BuildContext context) {
    final user = UsuarioProvider.of(context)?.usuario;
    final TextEditingController identificacionController =
    TextEditingController(text: user?.identificacion);
    final TextEditingController correoController =
    TextEditingController(text: user?.email);
    TextEditingController? placaController;
    TextEditingController? modeloController;
    TextEditingController? colorController;
    if (user is ConductorAmigo) {
      placaController = TextEditingController(text: user.placa);
      modeloController = TextEditingController(text: user.modelo);
      colorController = TextEditingController(text: user.color);
    }
    final TextEditingController rolController =
    TextEditingController(text: user?.rol);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                color: const Color(0xFF7DB006),
                height: 170,
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Image.asset(
                    'lib/asset/image/UdeaImagen.png',
                  ),
                ),
              ),
              const SizedBox(
                height: 58,
                width: 50,
                child: OverflowBox(
                  maxWidth: 200,
                  maxHeight: 200,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.account_circle_sharp,
                    color: Colors.grey,
                    size: 120,
                  ),
                ),
              ),
              const SizedBox(height: 20),
               Text(
                user!.nombre,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w400,
                    fontSize: 25),
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xFF7DB006),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFF7DB006),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFF7DB006),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFF7DB006),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFF7DB006),
                          ),
                          SizedBox(width: 15, height: 30),
                          Text(
                            "5,0 estrellas",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ],
                      ))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      _buildInputField(identificacionController, "Identificacion"),
                      _buildInputField(correoController, "Correo Institucional"),
                      _buildInputField(rolController, "Rol"),
                      _buildInputField(modeloController!, "Modelo Vehiculo"),
                      _buildInputField(placaController!, "Placa Vehiculo"),
                      _buildInputField(colorController!, "Color Vehiculo"),

                      const SizedBox(height: 60),
                      _buildElevatedButton(0xFFC74A4D, "Cerrar Sesion", true),
                      const SizedBox(height: 20),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInputField(TextEditingController controller, String labelName,
    {isPassword = false}) {
  return TextField(
    controller: controller,
    readOnly: true,
    decoration: InputDecoration(
      labelText: labelName,
      labelStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w400),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2)),
      disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1)),
    ),
    obscureText: isPassword,
  );
}