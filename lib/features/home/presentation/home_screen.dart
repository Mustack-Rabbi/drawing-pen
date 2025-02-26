import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Draw Pen"),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/draw");
              },
              child: Text("Go to Draw"))),
    );
  }
}
