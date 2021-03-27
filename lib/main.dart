import 'package:flutter/material.dart';
import 'package:qr_code_buddy/generate_screen.dart';
import 'package:qr_code_buddy/scan_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(QRBuddy());
}

class QRBuddy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/scan': (context) => ScanScreen(),
        '/generate': (context) => GenerateScreen(),
      },
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
    );
  }
}
