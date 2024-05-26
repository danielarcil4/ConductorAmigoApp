import 'package:conductor_amigo/pages/ConductorAmigo/conductor_amigo_page.dart';
import 'package:flutter/material.dart';
import 'Login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _closeSplash();
    super.initState();
  }

  Future<void> _closeSplash() async{
    Future.delayed(const Duration(seconds: 2),() async{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF7DB006),
      body:
      Padding(padding: EdgeInsets.symmetric(horizontal: 32,vertical: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(
                image: AssetImage('lib/asset/image/ConductorAmigoLogo.png'),
                fit: BoxFit.fill,
                width: 300,
              ),
              SizedBox(height: 300,),
              Text('CONDUCTOR AMIGO',
                style: TextStyle(color: Colors.white,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

