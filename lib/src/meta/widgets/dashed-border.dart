import 'dart:ui';

import 'package:flutter/material.dart';

class DashedBorderBox extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Color color;
  final double gap;
  final double dashWidth;
  final BorderRadius borderRadius;

  const DashedBorderBox({
    Key? key,
    required this.child,
    this.strokeWidth = 2.0,
    this.color = Colors.black,
    this.gap = 5.0,
    this.dashWidth = 5.0,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RoundedDashedPainter(
        strokeWidth: strokeWidth,
        color: color,
        gap: gap,
        dashWidth: dashWidth,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class RoundedDashedPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;
  final double dashWidth;
  final BorderRadius borderRadius;

  RoundedDashedPainter({
    required this.strokeWidth,
    required this.color,
    required this.gap,
    required this.dashWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final outerRect = Offset.zero & size;
    final rRect = borderRadius.toRRect(outerRect);

    final path = Path()..addRRect(rRect);
    final dashedPath = _createDashedPath(path, dashWidth, gap);

    canvas.drawPath(dashedPath, paint);
  }

  /// Converts a solid path into a dashed one
  Path _createDashedPath(Path source, double dashLength, double gapLength) {
    final Path result = Path();
    final PathMetrics metrics = source.computeMetrics(forceClosed: false);

    for (final PathMetric metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double nextDashLength =
            distance + dashLength < metric.length
                ? dashLength
                : metric.length - distance;

        result.addPath(
          metric.extractPath(distance, distance + nextDashLength),
          Offset.zero,
        );

        distance += dashLength + gapLength;
      }
    }

    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
