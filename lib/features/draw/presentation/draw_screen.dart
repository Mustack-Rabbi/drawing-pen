import 'package:drawing_pen/features/draw/models/stroke.dart';
import 'package:flutter/material.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({super.key});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  List<Stroke> strokes = [];
  List<Stroke> _redoStokes = [];
  List<Stroke> _currentPoints = [];
  Color _selectedColor = Colors.black;
  double _brushSize = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draw Now"),
      ),
      body: Column(),
    );
  }
}
