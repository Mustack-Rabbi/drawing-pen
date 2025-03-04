import 'package:drawing_pen/features/draw/models/stroke.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({super.key});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  List<Stroke> _strokes = [];
  List<Stroke> _redoStrokes = [];
  List<Offset> _currentPoints = [];
  Color _selectedColor = Colors.black;
  double _brushSize = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draw Now"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  _currentPoints.add(details.localPosition);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _currentPoints.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _strokes.add(Stroke(
                      points: List.from(_currentPoints),
                      color: _selectedColor,
                      brushSize: _brushSize));
                });
                _currentPoints = [];
                _redoStrokes = [];
              },
              child: CustomPaint(
                painter: DrawPainter(
                    strokes: _strokes,
                    currentPaints: _currentPoints,
                    currentColor: _selectedColor,
                    currentBrushSize: _brushSize),
                size: Size.infinite,
              ),
            ),
          ),
          _buildToolBar()
        ],
      ),
    );
  }

  Widget _buildToolBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: _strokes.isNotEmpty
                  ? () {
                      setState(() {
                        _redoStrokes.add(_strokes.removeLast());
                      });
                    }
                  : null,
              icon: Icon(Icons.undo)),
          IconButton(
              onPressed: _redoStrokes.isNotEmpty
                  ? () {
                      setState(() {
                        _strokes.add(_redoStrokes.removeLast());
                      });
                    }
                  : null,
              icon: Icon(Icons.redo))
        ],
      ),
    );
  }
}

class DrawPainter extends CustomPainter {
  final List<Stroke> strokes;
  final List<Offset> currentPaints;
  final Color currentColor;
  final double currentBrushSize;

  DrawPainter({
    super.repaint,
    required this.strokes,
    required this.currentPaints,
    required this.currentColor,
    required this.currentBrushSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //Draw completed strokes

    for (final stroke in strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeCap = StrokeCap.round
        ..strokeWidth = stroke.brushSize;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        if (stroke.points[i] != Offset.zero &&
            stroke.points[i + 1] != Offset.zero) {
          canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
        }
      }
    }
    final paint = Paint()
      ..color = currentColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = currentBrushSize;

    for (int i = 0; i < currentPaints.length - 1; i++) {
      if (currentPaints[i] != Offset.zero &&
          currentPaints[i + 1] != Offset.zero) {
        canvas.drawLine(currentPaints[i], currentPaints[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
