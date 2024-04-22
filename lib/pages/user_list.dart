import 'package:conductor_amigo/pages/auth_service.dart';
import 'package:conductor_amigo/pages/chat_page.dart';
import 'package:conductor_amigo/pages/chat_services.dart';
import 'package:conductor_amigo/pages/chats_usuario_page.dart';
import 'package:conductor_amigo/pages/user_tile.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0), // Ajusta el espaciado vertical aquí
          child: _buildUserList(),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasError){
          return const Text("Error");
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading ..");
        }

        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento del ListView
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    if(userData["email"] != _authService.geCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChatPage(
                      receiverEmail: userData["email"], receiverID: userData["uid"],
                    ),
              )
          );
        },
      );
    } else {
      return Container();
    }
  }
}
