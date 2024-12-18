import 'package:echat/components/navigation_button.dart';
import 'package:echat/screens/registry_screen.dart';
import 'package:echat/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static String id = "mainScreen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'chatIcon.png',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),
            const Text(
              "E-Chat",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            NavigationButton(
              label: 'Register',
              routeName: RegistryScreen.id,
            ),
            const SizedBox(height: 16),
            NavigationButton(
              label: 'Sign-in',
              routeName: SignInScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}
