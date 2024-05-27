class UsuarioComun {
  final String nombre;
  final String email;
  final String rol;
  final String uid;
  final String identificacion;

  UsuarioComun({
    required this.nombre,
    required this.email,
    required this.rol,
    required this.uid,
    required this.identificacion,
  });

  factory UsuarioComun.fromMap(Map<String, dynamic> data) {
    return UsuarioComun(
      uid: data['uid'],
      nombre: data['username'],
      email: data['email'],
      rol: data['rol'],
      identificacion: data['identificacion'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': nombre,
      'email': email,
      'rol': rol,
      'identificacion': identificacion,
    };
  }
}
