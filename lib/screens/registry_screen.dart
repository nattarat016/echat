import 'package:echat/components/text_input.dart';
import 'package:flutter/material.dart';

class RegistryScreen extends StatefulWidget {
    static String id = "RegistryScreen";
  const RegistryScreen({super.key});

  @override
  State<RegistryScreen> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text("registry screen"),
    ),
    body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'chatIcon.png',
                  scale: 3,
                ),
                const Text('Register',style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            const TextInput(
              hintText: "Enter Email",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15,),
            const TextInput(
              hintText: "Enter Password",
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextButton(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all<Size>(const Size.fromHeight(50)),
                backgroundColor: WidgetStateProperty.all(Colors.lightBlueAccent.shade700),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: () {},
              child: const Text('Next'),
            ),
          )
          ],
        ),
      ),);
  }
}