import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatedText extends StatefulWidget {
  @override
  _DateFormatedTextState createState() => _DateFormatedTextState();
}

class _DateFormatedTextState extends State<DateFormatedText> {
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(days: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String getDate() {
    DateFormat format = new DateFormat.yMMMMEEEEd();
    return format.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(
      getDate(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: theme.textTheme.body1.color.withOpacity(0.7),
      ),
    );
  }
}
