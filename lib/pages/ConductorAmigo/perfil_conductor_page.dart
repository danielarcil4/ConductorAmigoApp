import 'package:flutter/material.dart';

class PerfilConductorPage extends StatefulWidget {
  const PerfilConductorPage({super.key});

  @override
  State<PerfilConductorPage> createState() => _PerfilConductorPageState();
}

class _PerfilConductorPageState extends State<PerfilConductorPage> {
  final TextEditingController _identificacionController =
  TextEditingController(text: "1004.193.180");
  final TextEditingController _correoController =
  TextEditingController(text: "daniel.yepez@udea.edu.co");
  final TextEditingController _placaController =
  TextEditingController(text: "AUY 640");
  final TextEditingController _modeloController =
  TextEditingController(text: "Chevrolet Optra");
  final TextEditingController _colorController =
  TextEditingController(text: "Gris");
  final TextEditingController _rolController =
  TextEditingController(text: "Conductor Amigo");

  @override
  Widget build(BuildContext context) {
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
                // Without the OverflowBox, the child widget would be
                // constrained to the size of the parent container
                // and would not overflow the parent container.
                child: Icon(
                  Icons.account_circle_sharp,
                  color: Colors.grey,
                  size: 120,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Daniel Yépez',
              style: TextStyle(
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
                    _buildInputField(_identificacionController, "Identificacion"),
                    _buildInputField(_correoController, "Correo Institucional"),
                    _buildInputField(_rolController, "Rol"),
                    _buildInputField(_modeloController, "Modelo Vehiculo"),
                    _buildInputField(_placaController, "Placa Vehiculo"),
                    _buildInputField(_colorController, "Color Vehiculo"),
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
