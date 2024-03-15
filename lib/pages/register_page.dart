import 'package:conductor_amigo/pages/login_page.dart';
import 'package:conductor_amigo/pages/usuario_comun_page.dart';
import 'package:flutter/material.dart';

List<String> rolList = <String>['Elija su rol','Usuario Común', 'Conductor Amigo'];

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _identificacionController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();
  final TextEditingController _repetirContraseniaController = TextEditingController();
  String dropdownValue = rolList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
        SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 150,
                alignment: Alignment.center,
                color:  const Color(0xFF14612C),
                child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("¡Regístrate!",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                          fontSize: 30
                      ),
                    ),
                    Text("Aquí puedes crear tu nueva cuenta",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w300,
                            fontSize: 20
                        ),
                      )
                    ]
                  )
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 64),
                  child: Column(
                    children: [
                      const Text("Queremos conocerte, ingresa tus datos:",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                        ),
                      ),
                      _buildInputField(_identificacionController, "Identificacion"),
                      _buildInputField(_correoController, "Correo Institucional"),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down,
                          size: 35,
                        ),
                        elevation: 16,
                        isExpanded: true,
                        itemHeight: 60,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            if(value !='Elija su rol') {
                              dropdownValue = value!;
                            }
                          });
                        },items: rolList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            ),
                          ),
                        );
                      }).toList(),
                      ),
                      _buildInputField(_contraseniaController, "Contraseña",isPassword: true),
                      _buildInputField(_repetirContraseniaController, "Repetir Contraseña",isPassword: true),
                      const SizedBox(height: 150),
                      _buildElevatedButton(0xFF7DB006, "REGISTRARSE",true,context),
                      const SizedBox(height: 20),
                      _buildElevatedButton(0xFFC74A4D, "SALIR",false,context)
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

Widget _buildInputField(TextEditingController controller,String labelName,{isPassword = false}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.edit,
          size: 20,
        ),
        labelText: labelName,
        labelStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w400
        ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey,width: 1)
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey ,width: 2), // Cambia el color de resaltado aquí
        ),
    ),
    obscureText: isPassword,
  );
}

Widget _buildElevatedButton(int colorButton, String text,bool registrarUsuario,BuildContext context){
  return ElevatedButton(onPressed: (){
    if(registrarUsuario) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UsuarioComunPage())
      );
    }
    else{
      _mostrarMensaje(context);
    }
  },
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color(colorButton),
        elevation: 20,
        shadowColor: const Color(0xFF14612C),
        minimumSize: const Size.fromHeight(50)
    ),
    child: Text(text,
      style: const TextStyle(color: Colors.white,
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
          style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w500),
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
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                    // Agregar aquí la lógica para salir de la aplicación
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'CANCELAR',
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage())
                    );
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                  child: const Text(
                    'SALIR',
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w400,
                        color: Colors.red
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white
      );
    },
  );
}
