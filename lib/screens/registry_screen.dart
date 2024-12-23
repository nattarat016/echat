import 'package:echat/components/text_input.dart';
import 'package:echat/datas/input_with_error_text.dart';
import 'package:echat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class RegistryScreen extends StatefulWidget {
  static String id = "RegistryScreen";
  const RegistryScreen({super.key});

  @override
  State<RegistryScreen> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  final _auth = FirebaseAuth.instance;
  InputWithErrorText email = InputWithErrorText();
  InputWithErrorText password = InputWithErrorText();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("registry screen"),
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
                      'Register',
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
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  inputWithErrorText: email,
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
                      progress?.showWithText('Loading');
                      try {
                        UserCredential userCredential =
                            await _auth.createUserWithEmailAndPassword(
                                email: email.valueText,
                                password: password.valueText);
                        if (userCredential.user != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } on FirebaseAuthException catch (e) {
                        progress?.dismiss();
                        if (e.code == 'weak-password') {
                          password.errorText = "Weak password";
                        } else if (e.code == 'email-already-in-use') {
                          email.errorText = 'Email already in use';
                        } else {
                          password.errorText = e.toString();
                        }
                      }
                      setState(() {
                        progress?.dismiss();
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
