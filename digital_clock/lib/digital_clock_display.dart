import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DigitalClockDisplay extends StatefulWidget {
  @override
  _DigitalClockDisplayState createState() => _DigitalClockDisplayState();
}

class _DigitalClockDisplayState extends State<DigitalClockDisplay> {
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String getHM() {
    DateFormat format = new DateFormat("hh:mm");
    return format.format(DateTime.now());
  }

  String getSeconds() {
    DateFormat format = new DateFormat("ss");
    return format.format(DateTime.now());
  }

  String getAmOrPm() {
    DateFormat format = new DateFormat("aaa");
    return format.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            getHM(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 100,
              color: Theme.of(context).textTheme.body1.color.withOpacity(0.7),
            ),
          ),
          Text(
            getSeconds(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).textTheme.body1.color.withOpacity(0.3),
            ),
          ),
          Expanded(
            child: FittedBox(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                getAmOrPm(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .textTheme
                        .body1
                        .color
                        .withOpacity(0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
