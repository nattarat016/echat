import 'package:echat/screens/chat_screen.dart';
import 'package:echat/screens/main_screen.dart';
import 'package:echat/screens/registry_screen.dart';
import 'package:echat/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue  
      ),
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id : (context)=> const MainScreen(), 
        RegistryScreen.id : (context)=> const RegistryScreen(),
        SignInScreen.id: (context)=> const SignInScreen(),
        ChatScreen.id : (context)=> const ChatScreen(),
      },
    );
  }
}
