// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:analog_clock/location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

import 'anlog_clock_display.dart';
import 'date_text.dart';
import 'temperature.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: buildContainer(
                    margin: EdgeInsets.only(right: 5),
                    child: AnalogClockDisplay(),
                    padding: EdgeInsets.all(10),
                  ),
                ),
                buildContainer(
                  child: DateFormatedText(),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top: 10, right: 5),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: buildContainer(
                    margin: EdgeInsets.only(left: 5),
                    child: TemperatureView(model: widget.model),
                  ),
                ),
                buildContainer(
                  child: LocationView(model: widget.model),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top: 10, left: 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer(
      {@required Widget child,
      EdgeInsetsGeometry margin,
      EdgeInsetsGeometry padding}) {
    var theme = Theme.of(context);
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.brightness == Brightness.light
            ? Colors.black.withOpacity(0.05)
            : Colors.white.withOpacity(0.05),
      ),
      child: child,
    );
  }
}
