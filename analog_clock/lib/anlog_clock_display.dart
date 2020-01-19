import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'clock_circle_painter.dart';

class AnalogClockDisplay extends StatefulWidget {
  @override
  _AnalogClockDisplayState createState() => _AnalogClockDisplayState();
}

class _AnalogClockDisplayState extends State<AnalogClockDisplay> {
  Timer timer;
  void onChange(Timer timer) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), onChange);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constrains) {
        return Center(
          child: SizedBox(
            width: min(constrains.maxHeight, constrains.maxWidth),
            height: min(constrains.maxHeight, constrains.maxWidth),
            child: CustomPaint(
              painter: ClockCirclePainter(
                bigDotColor: theme.brightness == Brightness.dark
                    ? Colors.white54
                    : Colors.black54,
                mediumDotColor: theme.brightness == Brightness.dark
                    ? Colors.white38
                    : Colors.black38,
                smallDotColor: theme.brightness == Brightness.dark
                    ? Colors.white24
                    : Colors.black26,
                secondsHand: Colors.amber,
                hoursHand: theme.brightness == Brightness.dark
                    ? Colors.white24
                    : Colors.black26,
                minutesHand: theme.brightness == Brightness.dark
                    ? Colors.white60
                    : Colors.black54,
              ),
            ),
          ),
        );
      },
    );
  }
}
