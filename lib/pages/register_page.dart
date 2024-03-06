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
  String dropdownValue = rolList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
        Center(
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
                child: SingleChildScrollView(
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
                      _buildInputField(_correoController, "Correo institucional"),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 230),
                      _buildElevatedButton(0xFF7DB006, "REGISTRARSE"),
                      const SizedBox(height: 20),
                      _buildElevatedButton(0xFFC74A4D, "SALIR")

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
        )
    ),
    obscureText: isPassword,
  );
}

Widget _buildElevatedButton(int colorButton, String text){
  return ElevatedButton(onPressed: (){},
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