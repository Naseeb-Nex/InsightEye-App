import 'package:flutter/material.dart';
import 'dart:math';

import 'package:insighteye_app/constants/constants.dart';

class CircularProgressBar extends StatelessWidget {
  final double strokeWidth;
  final double progress;
  final int totalCount;
  final int completedCount;

  const CircularProgressBar({
    super.key,
    required this.strokeWidth,
    required this.progress,
    required this.totalCount,
    required this.completedCount,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircleProgressBarPainter(
        strokeWidth: strokeWidth,
        progress: progress,
      ),
      child: SizedBox(
        width: 180,
        height: 180,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$completedCount',
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF5215D9)),
                ),
                const Text(
                  'to complete',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF5215D9)),
                ),
                Text(
                  '$totalCount',
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF5215D9)),
                ),
                const Text(
                  'total',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF5215D9)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double strokeWidth;
  final double progress;

  CircleProgressBarPainter({
    required this.strokeWidth,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0XFFD9D9D9)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (strokeWidth / 2);

    // Draw the background circle
    canvas.drawCircle(center, radius, paint);

    final progressPaint = Paint()
      ..color = techc
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Calculate the sweep angle based on progress
    final progressAngle = -2 * pi * (progress / 100);

    // Draw the progress arc with rounded edges
    final arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      arcRect,
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
