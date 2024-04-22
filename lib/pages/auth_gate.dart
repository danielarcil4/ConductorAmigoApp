import 'package:conductor_amigo/pages/login_page.dart';
import 'package:conductor_amigo/pages/usuario_comun_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const UsuarioComunPage();
          }

          else {
            return const LoginPage();
          }

        },
      ),
    );
  }
}
