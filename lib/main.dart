import 'package:flutter/material.dart';
import 'package:magang/modules/home/provider/user_provider.dart';
import 'package:magang/modules/palindrome/palindrome_screen.dart';
import 'package:magang/modules/palindrome/provider/palindrome_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PalindromeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const InitialApp(),
    ),
  );
}

class InitialApp extends StatelessWidget {
  const InitialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suitmedia Test',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const PalindromeScreen(),
    );
  }
}
