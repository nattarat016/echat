import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  static String id = "ChatScreen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user;
  final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('time', descending: true)
      .snapshots();
  String message = '';
  final messageController = TextEditingController();

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
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("chat screen"),
        leading: null,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!context.mounted) return;
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: messageStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return const Text('something went wrong TT');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('please wait... ');
                }
                return Expanded(
                    child: ListView(
                  reverse: true,
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot documentSnapshot) {
                    Map<String, dynamic> data =
                        documentSnapshot.data() as Map<String, dynamic>;
                    bool isMe = user!.email == data['sender'];
                    return Padding(
                      padding: const EdgeInsets.all(0.5),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(data['sender']),
                          Text(data['text']),
                          Text(data['time'] == null
                              ? 'N/A'
                              : DateFormat.yMMMMd()
                                  .add_jm()
                                  .format(data['time'].toDate()))
                        ],
                      ),
                    );
                  }).toList(),
                ));
              }),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: null,
                  controller: messageController,
                  onChanged: (value) {
                    message = value;
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    hintText: 'Type  yourmessage here...',
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    log(message);
                    messageController.clear();
                    FirebaseFirestore.instance.collection('messages').add({
                      'sender': user!.email,
                      'text': message,
                      'time': FieldValue.serverTimestamp()
                    });
                  },
                  child: const Text('send')),
            ],
          ),
        ],
      ),
    );
  }
}
