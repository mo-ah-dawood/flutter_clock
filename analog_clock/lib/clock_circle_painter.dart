import 'dart:math';

import 'package:flutter/material.dart';

class ClockCirclePainter extends CustomPainter {
  final Color bigDotColor;
  final Color mediumDotColor;
  final Color smallDotColor;
  final Color secondsHand;
  final Color hoursHand;
  final Color minutesHand;
  DateTime get dateTime => DateTime.now();
  ClockCirclePainter({
    this.secondsHand = Colors.redAccent,
    this.hoursHand = Colors.blueAccent,
    this.minutesHand = Colors.blue,
    this.mediumDotColor = Colors.brown,
    this.bigDotColor = Colors.blue,
    this.smallDotColor = Colors.red,
  });

  void drawDot(
      Canvas canvas, Size size, double _radius, double angle, Color color) {
    var radius = (min(size.height, size.width) / 2) - (_radius);
    var centerY = size.height / 2;
    var centerX = size.width / 2;
    var x = centerX + (radius * cos(angle * pi / 180));
    var y = centerY + (radius * sin(angle * pi / 180));
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = color;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeCap = StrokeCap.round;
    var offset = Offset(x, y);
    canvas.drawCircle(offset, _radius, paint);
  }

  void drawHand(Canvas canvas, Size size, int angle, double stroke, double edge,
      Color color) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = color;
    paint.strokeWidth = stroke;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeCap = StrokeCap.round;
    var radius = (min(size.height, size.width) / 2) - edge;
    var centerY = size.height / 2;
    var centerX = size.width / 2;
    var x = centerX + (radius * cos((angle - 90) * pi / 180));
    var y = centerY + (radius * sin((angle - 90) * pi / 180));
    canvas.drawLine(Offset(centerX, centerY), Offset(x, y), paint);
  }

  void drawContanerCircle(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = Colors.transparent;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeCap = StrokeCap.round;
    var radius = min(size.height, size.width) / 2;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
    drawHand(canvas, size, dateTime.hour * 30, 4, size.width * 0.25, hoursHand);
    drawHand(
        canvas, size, dateTime.minute * 6, 3, size.width * 0.2, minutesHand);
    drawHand(
        canvas, size, dateTime.second * 6, 2, size.width * 0.16, secondsHand);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        size.width * 0.02, paint..color = secondsHand);
  }

  void drawPainter(
    Canvas canvas,
    Size size,
    TextPainter painter,
    double angle,
  ) {
    var radius = (min(size.height, size.width) / 2) - size.width * .07;
    var centerY = size.height / 2;
    var centerX = size.width / 2;
    var x = centerX + (radius * cos(angle * pi / 180));
    var y = centerY + (radius * sin(angle * pi / 180));

    var offset = Offset(x - painter.width / 2, y - painter.height / 2);
    painter.paint(canvas, offset);
  }

  TextPainter _getTextPainter(String char, Color color, double fontSize) {
    var painter = TextPainter(
      text: TextSpan(
          text: (char).toString(),
          style: TextStyle(
            color: color,
            fontSize: fontSize,
          )),
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    return painter;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawContanerCircle(canvas, size);
    var _nums = ["3", "6", "9", "12"];
    for (var i = 0; i < 60; i++) {
      if (i ~/ 15 == i / 15) {
        drawPainter(
            canvas,
            size,
            _getTextPainter(_nums[i ~/ 15], bigDotColor, size.width * .06),
            i * (360 / 60));
        drawDot(canvas, size, 3, i * (360 / 60), bigDotColor);
      } else if (i ~/ 5 == i / 5) {
        drawPainter(
            canvas,
            size,
            _getTextPainter((i ~/ 5 <= 8 ? i ~/ 5 + 3 : i ~/ 5 - 9).toString(),
                bigDotColor, size.width * .03),
            i * (360 / 60));
        drawDot(canvas, size, 2, i * (360 / 60), mediumDotColor);
      } else
        drawDot(canvas, size, 1, i * (360 / 60), smallDotColor);
    }
  }

  @override
  bool shouldRepaint(ClockCirclePainter oldDelegate) {
    return true;
  }
}
