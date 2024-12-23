import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String id = "ChatScreen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user;

  void getCurrentUser() {
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      log('User is null');
    } else {
      log(user!.email.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("chat screen"),
        leading: null,
        actions: [
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            if (!context.mounted) return;
              Navigator.pop(context);
            
          }, icon: const Icon(Icons.close))
        ],
      ),
    );
  }
}
