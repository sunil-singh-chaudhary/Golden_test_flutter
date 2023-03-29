import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test_first_demo/WeatherForecast.dart';

void main() {
  const List<Forecast> thisWeek = [
    Forecast(
      weather: Weather.sunny,
      temp: 90,
      day: 'Saturday',
      description: 'Partly cloudy. High 90F. Winds W at 5 to 10 mph.',
    ),
    Forecast(
      weather: Weather.cloudy,
      temp: 75,
      day: 'Sunday',
      description: 'Partly cloudy. High 90F. Winds W at 5 to 10 mph.',
    ),
    Forecast(
      weather: Weather.cloudy,
      temp: 70,
      day: 'Monday',
      description: 'Partly cloudy. High 90F. Winds W at 5 to 10 mph.',
    ),
    Forecast(
      weather: Weather.rain,
      temp: 65,
      day: 'Tuesday',
      description: 'Partly cloudy. High 90F. Winds W at 5 to 10 mph.',
    ),
    Forecast(
      weather: Weather.cold,
      temp: 7,
      day: 'Wednesday',
      description: 'Partly cloudy. High 90F. Winds W at 5 to 10 mph.',
    ),
  ];
  testWidgets(
    'Testing UI wheather Forecast',
    (tester) async {
      await tester.pumpWidget(const MediaQuery(
        data: MediaQueryData(),
        child: WeatherForecast(
          list: thisWeek,
        ),
      ));
    },
  );
}
