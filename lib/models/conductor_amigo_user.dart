import 'package:conductor_amigo/models/usuario_comun_user.dart';

class ConductorAmigo extends UsuarioComun {
  final String modelo;
  final String placa;
  final String color;

  ConductorAmigo({
    required super.uid,
    required super.identificacion,
    required super.nombre,
    required super.email,
    required super.rol,
    required this.modelo,
    required this.placa,
    required this.color,
  });

  factory ConductorAmigo.fromMap(Map<String, dynamic> data) {
    return ConductorAmigo(
      uid: data['uid'],
      nombre: data['username'],
      email: data['email'],
      rol: data['rol'],
      modelo: data['vehiculo']['modelo'],
      placa: data['vehiculo']['placa'],
      color: data['vehiculo']['color'],
      identificacion: data['identificacion'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'modelo': modelo,
        'placa': placa,
        'color': color,
      });
  }
}
