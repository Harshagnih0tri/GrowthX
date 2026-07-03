import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_shell.dart';
void main() {
  runApp(const GrowthXApp());
}

class GrowthXApp extends StatelessWidget {
  const GrowthXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowthX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AppShell(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'GrowthX 🚀',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}