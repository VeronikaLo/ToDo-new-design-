import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  final double donePercent;
  final double barWidth;
  final double barHeight;
  final Color bgColor;
  final Color percentageColor;

  ProgressPainter(
      {required this.donePercent,
      required this.barWidth,
      required this.barHeight,
      required this.bgColor,
      required this.percentageColor});

  // pencil function
  getPaint(Color color) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultBarPaint = getPaint(bgColor);
    Paint percentageBarPaint = getPaint(percentageColor);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Offset(-barWidth / 2, -barHeight / 3) & Size(barWidth, barHeight),
            Radius.circular(barHeight / 2)),
        defaultBarPaint);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Offset(-barWidth / 2, -barHeight / 3) &
                Size(barWidth * donePercent, barHeight),
            Radius.circular(barHeight / 2)),
        percentageBarPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // if smth changes --> redrraw
  }
}

//const Color.fromARGB(255, 232, 209, 209)