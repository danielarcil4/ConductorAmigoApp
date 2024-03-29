import 'package:conductor_amigo/pages/perfil_usuario_page.dart';
import 'package:conductor_amigo/pages/viajes_anteriores_page.dart';
import 'chats_usuario_page.dart';
import 'package:flutter/material.dart';

class UsuarioComunPage extends StatefulWidget {
  const UsuarioComunPage({super.key});

  @override
  State<UsuarioComunPage> createState() => _UsuarioComunPageState();
}

class _UsuarioComunPageState extends State<UsuarioComunPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const ViajesAnterioresPage(),
    const PerfilUsuarioPage(),
    const ChatsUsuarioPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF14612C),
        selectedItemColor: const Color(0xFF7DB006),
        unselectedItemColor: Colors.white,
        items: [
           BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 0 ? Icons.home : Icons.home_outlined
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 1 ? Icons.person : Icons.person_outlined),
            label: 'Inicio',
          ),
           BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ?  Icons.mark_chat_unread : Icons.mark_chat_unread_outlined,
            ),
            label: 'Chats',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body:
        _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

