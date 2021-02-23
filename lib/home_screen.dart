import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner and Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/scan');
              },
              child: Text('Scan'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/generate');
              },
              child: Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
