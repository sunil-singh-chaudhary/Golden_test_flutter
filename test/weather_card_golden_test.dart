import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test_first_demo/WeatherForecast.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('Basic Golden test', () {
    /// This test uses .pumpWidgetBuilder to automatically set up
    /// the appropriate Material dependencies in order to minimize boilerplate.
    /// It simply pumps a custom widget and captures the golden

    testGoldens('single wheather card look good', (tester) async {
      await loadAppFonts();
      await tester.pumpWidgetBuilder(
        const Center(
          child: WeatherCard(temp: 66, weather: Weather.sunny),
        ),
        surfaceSize: const Size(200, 200),
      );
      await screenMatchesGolden(tester, 'single_weather_card');
    });
  });

  /// GoldenBuilder allows you to scaffold out a single widget containing multiple test scenarios
  /// for a given widget under test.
  group('GoldenBuilder', () {
    /// lays out the results in a grid
    testGoldens('Multiple test scenerio on wheather card', (tester) async {
      await loadAppFonts();
      final gb = GoldenBuilder.grid(
        columns: 2,
        bgColor: Colors.white,
        widthToHeightRatio: 1,
      )
        ..addScenario(
          'sunny',
          const WeatherCard(temp: 97, weather: Weather.sunny),
        )
        ..addScenario(
          'Rainy',
          const WeatherCard(temp: 35, weather: Weather.rain),
        )
        ..addScenario(
          'cloudy',
          const WeatherCard(temp: 45, weather: Weather.cloudy),
        )
        ..addScenario(
          'cold',
          const WeatherCard(temp: 12, weather: Weather.cold),
        );

      await tester.pumpWidgetBuilder(
        gb.build(),
        surfaceSize: const Size(500, 500),
      );
      await screenMatchesGolden(tester, 'weather_types_grid');
    });
  });

  /// lays out the results in a column
  /// if are showing anything in column then use this below
  testGoldens('COLUMN: Different weather types with extra frame',
      (tester) async {
    await loadAppFonts();
    final gb = GoldenBuilder.column(
      bgColor: Colors.white,
      wrap: _simpleFrame,
    )
      ..addScenario(
          'Sunny', const WeatherCard(temp: 66, weather: Weather.sunny))
      ..addScenario(
          'Cloudy', const WeatherCard(temp: 56, weather: Weather.cloudy));

    await tester.pumpWidgetBuilder(
      gb.build(),
      surfaceSize: const Size(120, 900),
    );
    await screenMatchesGolden(tester, 'weather_types_column');
  });

  /// Demonstrates how golden builder can be combined with multiScreenGolden to
  /// test with multiple dimensions of parameters
  testGoldens('Card should look right on different devices / screen sizes',
      (tester) async {
    await loadAppFonts();
    final gb = GoldenBuilder.column(bgColor: Colors.white)
      ..addScenario(
          'Sunny', const WeatherCard(temp: 66, weather: Weather.sunny))
      ..addScenario(
          'Cloudy', const WeatherCard(temp: 56, weather: Weather.cloudy))
      ..addScenario(
          'Raining', const WeatherCard(temp: 37, weather: Weather.rain))
      ..addScenario('Cold', const WeatherCard(temp: 25, weather: Weather.cold))
      ..addTextScaleScenario(
          'Cold', const WeatherCard(temp: 25, weather: Weather.cold));

    await tester.pumpWidgetBuilder(
      gb.build(),
      surfaceSize: const Size(200, 1200),
    );

    await multiScreenGolden(
      tester,
      'all_sized_all_fonts',
      devices: [
        Device.phone,
        Device.tabletLandscape,
        Device.iphone11,
        Device.tabletPortrait
      ],
      overrideGoldenHeight: 1200,
    );
  });

  group('GoldenBuilder examples of accessibility testing', () {
    // With those test we want to make sure our widgets look right when user changes system font size
    testGoldens('Card should look right when user bumps system font size',
        (tester) async {
      await loadAppFonts();
      const widget = WeatherCard(temp: 56, weather: Weather.cloudy);

      final gb = GoldenBuilder.column(bgColor: Colors.white, wrap: _simpleFrame)
        ..addScenario('Regular font size', widget)
        ..addTextScaleScenario('Large font size', widget, textScaleFactor: 2.0);

      await tester.pumpWidgetBuilder(
        gb.build(),
        surfaceSize: const Size(200, 1000),
      );
      await screenMatchesGolden(tester, 'weather_accessibility');
    });
  });

  group('Multi-Screen Golden', () {
    testGoldens('Example of testing a responsive layout', (tester) async {
      await loadAppFonts();
      await tester.pumpWidgetBuilder(const WeatherForecast());

      await multiScreenGolden(tester, 'weather_forecast');
    });
  });
}

Widget _simpleFrame(Widget child) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(color: const Color(0xFF9E9E9E)),
    ),
    child: child,
  );
}
