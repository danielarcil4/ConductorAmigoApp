import 'package:flutter/material.dart';

class PerfilUsuarioPage extends StatefulWidget {
  const PerfilUsuarioPage({super.key});

  @override
  State<PerfilUsuarioPage> createState() => _PerfilUsuarioPageState();
}

class _PerfilUsuarioPageState extends State<PerfilUsuarioPage> {
  final TextEditingController _identificacionController =
      TextEditingController(text: "1007.316.496");
  final TextEditingController _correoController =
      TextEditingController(text: "daniel.arcila@udea.edu.co");
  final TextEditingController _rolController =
      TextEditingController(text: "Usuario Común");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              'Daniel Gómez',
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
                  ],
                )),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12,),
                    const Text(
                      "¿En hora pico?, ¿y vas a coger bus?",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                          fontSize: 17),
                    ),
                    const Text(
                      "Reserva desde ya tu conductorAmigo\n"
                      "y ¡olvídate de tus problemas!",
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7DB006),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                        ),
                        label: const Text(
                          "Únete a Amigo",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.white,
                            size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,)
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
