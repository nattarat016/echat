import 'dart:developer';

import 'package:echat/components/text_input.dart';
import 'package:echat/datas/input_with_error_text.dart';
import 'package:echat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class SignInScreen extends StatefulWidget {
  static String id = "SignInScreen";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  InputWithErrorText email = InputWithErrorText();
  InputWithErrorText password = InputWithErrorText();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sign in screen"),
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
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'chatIcon.png',
                      scale: 3,
                    ),
                    const Text(
                      'Sign-In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextInput(
                  hintText: "Enter Email",
                  keyboardType: TextInputType.emailAddress,
                  inputWithErrorText: email,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextInput(
                  hintText: "Enter Password",
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  inputWithErrorText: password,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all<Size>(
                          const Size.fromHeight(50)),
                      backgroundColor: WidgetStateProperty.all(
                          Colors.lightBlueAccent.shade700),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: () async {
                      final progress = ProgressHUD.of(context);
                      progress!.showWithText('Loading');
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email.valueText,
                            password: password.valueText);
                        if (!context.mounted) return;
                        Navigator.pushNamed(context, ChatScreen.id);
                      } on FirebaseAuthException catch (e) {
                        // progress.dismiss();
                        if (e.code == 'user-not-found') {
                          email.errorText = 'User not found';
                        } else if (e.code == 'wrong-password') {
                          password.errorText = 'wrong-password';
                        } else if(e.code == 'invalid-email'){
                          log(email.errorText.toString());
                          email.errorText = 'invalid-email';
                          log(email.errorText.toString());
                        } else {
                          log('dsf');
                          password.errorText = e.toString();
                        }
                      }
                      setState(() {
                        progress.dismiss();
                      });
                    },
                    child: const Text('Next'),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
