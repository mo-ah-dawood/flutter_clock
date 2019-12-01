import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:weather_icons/weather_icons.dart';

class TemperatureView extends StatefulWidget {
  final ClockModel model;

  const TemperatureView({Key key, @required this.model}) : super(key: key);
  @override
  _TemperatureViewState createState() => _TemperatureViewState();
}

class _TemperatureViewState extends State<TemperatureView> {
  ClockModel model;
  Map<WeatherCondition, IconData> get icons => {
        WeatherCondition.cloudy: WeatherIcons.cloud,
        WeatherCondition.sunny: WeatherIcons.day_sunny,
        WeatherCondition.foggy: WeatherIcons.fog,
        WeatherCondition.rainy: WeatherIcons.rain,
        WeatherCondition.snowy: WeatherIcons.snow,
        WeatherCondition.windy: WeatherIcons.cloudy_windy,
        WeatherCondition.thunderstorm: WeatherIcons.day_snow_thunderstorm,
      };
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

  Icon getWeatherIcon() {
    ThemeData themeData = Theme.of(context);
    Color color;
    if (model.weatherCondition == WeatherCondition.sunny) {
      color = themeData.brightness == Brightness.dark
          ? Colors.yellow
          : Colors.amber;
    }
    return Icon(
      icons[model.weatherCondition] ?? WeatherIcons.sunset,
      size: 30,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                      "${model.weatherString.toUpperCase()}",
                      style: TextStyle(
                          fontSize: model.weatherString.length > 10 ? 15 : 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 20),
                    child: getWeatherIcon(),
                  )
                ],
              ),
            ),
          ),
          FittedBox(
            child: Text(
              "${model.temperatureString}",
              style: TextStyle(
                fontSize: 60,
                color: themeData.textTheme.body1.color.withOpacity(0.75),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "${model.lowString} - ${model.highString}",
              style: TextStyle(
                fontSize: 10,
                color: themeData.textTheme.body1.color.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
