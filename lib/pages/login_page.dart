import 'package:conductor_amigo/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7DB006),
      body:
        Padding(padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 32,),
                const Image(
                      image: AssetImage('lib/asset/image/ConductorAmigoLogo.png'),
                      fit: BoxFit.fill,
                      width: 160,
                 ),
                _buildForm(),
                const Row(
                    children: [
                      Expanded(child:
                      Divider(
                        thickness: 1.2,
                        color: Colors.white,
                        endIndent: 20,
                      ),
                      ),
                      Text('O',
                        style: TextStyle(color: Colors.white,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w300),
                      ),
                      Expanded(child:
                      Divider(
                        thickness: 1.2,
                        color: Colors.white,
                        indent: 20,
                      ),
                      )
                    ],
                  ),
                ElevatedButton.icon(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RegisterPage())
                    );
                  },
                    icon: const Icon(Icons.mail_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xFFC2C8CF),
                      elevation: 20,
                      shadowColor: const Color(0xFF14612C),
                      minimumSize: const Size.fromHeight(50)
                  ),
                  label: const Text('INGRESAR CON GOOGLE',
                    style: TextStyle(color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
                const SizedBox(height: 32,),
                const Image(
                  image: AssetImage('lib/asset/image/UdeaLogo.png'),
                  fit: BoxFit.fill,
                  width: 120,
                ),
              ],
            ),
          ),
        ),
      );
  }
}

Widget _buildForm(){
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    return Column(
          children: [
            _buildInputField(idController,'Usuario o correo electrónico'),
            const SizedBox(height: 16,),
            _buildInputField(passwordController, 'Contraseña', isPassword: true),
            const SizedBox(height: 32,),
            _buildElevatedButton(0xFF14612C, 'INGRESAR'),
            const SizedBox(height: 16,)
        ],
      );
}

Widget _buildInputField(TextEditingController controller,String labelName,{isPassword = false}) {
  return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelName,
          labelStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w300
          ),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white,width: 2)
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