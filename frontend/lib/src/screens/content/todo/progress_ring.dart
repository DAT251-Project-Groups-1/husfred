import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vm;

class ProgressRing extends StatelessWidget {
  final double maxSize = 500;
  final double progress;

  const ProgressRing({required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: min(constraints.maxWidth * 2 / 3, maxSize),
                height: min(constraints.maxWidth * 2 / 3, maxSize),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: min(constraints.maxWidth * 0.2, maxSize * 0.2),
                        height: min(constraints.maxWidth * 0.2, maxSize * 0.2),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${(progress * 100).floor()}%",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox.expand(
                      child: CustomPaint(
                        painter: RingPainter(
                          strokeWidth:
                              min(constraints.maxWidth * 0.15, maxSize * 0.15),
                          progress: progress,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class RingPainter extends CustomPainter {
  final double strokeWidth;
  final double progress;

  RingPainter({required this.strokeWidth, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final inset = size.width * 0.18;

    final rect =
        Rect.fromLTRB(inset, inset, size.width - inset, size.height - inset);

    canvas.drawArc(
        rect,
        vm.radians(-90),
        vm.radians(360 * progress),
        false,
        Paint()
          ..shader = LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.lightGreenAccent,
                Colors.lightGreen,
                Colors.green,
              ]).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(RingPainter oldDelegate) {
    if (oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth) {
      return true;
    }
    return false;
  }
}
