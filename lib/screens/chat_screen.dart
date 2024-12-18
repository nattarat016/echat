import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
    static String id = "ChatScreen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text("chat screen"),
    ),);
  }
}