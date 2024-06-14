import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registration_screen.dart';
import 'display_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final storedName = prefs.getString('name');
  runApp(MyApp(
      initialScreen:
          storedName == null ? RegistrationScreen() : DisplayScreen()));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  MyApp({required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: initialScreen,
      debugShowCheckedModeBanner: false,
    );
  }
}
