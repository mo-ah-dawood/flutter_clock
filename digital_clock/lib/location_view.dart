import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class LocationView extends StatefulWidget {
  final ClockModel model;

  const LocationView({Key key, @required this.model}) : super(key: key);
  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  ClockModel model;
  void onChange() {
    setState(() {
      model = widget.model;
    });
  }

  @override
  void initState() {
    super.initState();
    model = widget.model;
    widget.model.addListener(onChange);
  }

  @override
  void dispose() {
    widget.model.removeListener(onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      model.location,
      textAlign: TextAlign.center,
    );
  }
}
