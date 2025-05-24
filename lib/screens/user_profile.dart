import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final Map user;

  const UserProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Name: ${user['name']}'),
            Text('Email: ${user['email']}'),
            // more fields here if needed
          ],
        ),
      ),
    );
  }
}
