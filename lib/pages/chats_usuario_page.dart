import 'package:flutter/material.dart';

class ChatsUsuarioPage extends StatefulWidget {
  const ChatsUsuarioPage({super.key});

  @override
  State<ChatsUsuarioPage> createState() => _ChatsUsuarioPageState();
}

class _ChatsUsuarioPageState extends State<ChatsUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('Chats')
        ],
      ),
    );
  }
}
