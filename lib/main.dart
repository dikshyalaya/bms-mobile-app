import 'package:beacon_flutter/features/auth/widget/login_screen.dart';
import 'package:beacon_flutter/utils/themes.dart';
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
      title: 'Beacon',
      debugShowCheckedModeBanner: false,
      theme: defaultLightTheme,
      home: const LoginScreen(),
    );
  }
}
