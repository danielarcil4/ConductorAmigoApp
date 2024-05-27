import 'package:conductor_amigo/models/usuario_comun_user.dart';
import 'package:flutter/material.dart';

class UsuarioProvider extends InheritedWidget {
  final UsuarioComun usuario;
  const UsuarioProvider({super.key, required this.usuario, required super.child});

  static UsuarioProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UsuarioProvider>();
  }

  @override
  bool updateShouldNotify(UsuarioProvider oldWidget) {
    return usuario != oldWidget.usuario;
  }
}