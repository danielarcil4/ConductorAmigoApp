import 'package:conductor_amigo/pages/chat/auth_service.dart';
import 'package:conductor_amigo/pages/chat/chat_page.dart';
import 'package:conductor_amigo/pages/chat/chat_services.dart';
import 'package:conductor_amigo/pages/chat/user_tile.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

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
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: _buildUserList(),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUsersStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text("No users found."); // Handle empty data scenario
        }

        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: snapshot.data!.map<Widget>((userData) {
            return _buildUserListItem(userData, context);
          }).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic>? userData, BuildContext context) {
    if (userData != null) {
      if (userData["email"] != _authService.getCurrentUser()!.email) {
        return UserTile(
          text: userData["email"],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData["email"],
                  receiverID: userData["uid"],
                ),
              ),
            );
          },
        );
      }
    }
    return Container(); // or any other widget you want to display
  }
}
