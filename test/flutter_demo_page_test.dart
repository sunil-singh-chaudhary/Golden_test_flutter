import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test_first_demo/FlutterDemoPage.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('DeviceBuilder - one scenario - default devices', (tester) async {
    final builder = DeviceBuilder()
      ..addScenario(widget: const FlutterDemoPage(), name: 'default page');

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'main'); //png name here
  });

  testGoldens('DeviceBuilder - one scenario - Override devices',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ])
      ..addScenario(widget: const FlutterDemoPage(), name: 'defaultpage');

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(
        tester, 'single_scenario_more_devices'); //png name here
  });

  testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ])
      ..addScenario(
        widget: const FlutterDemoPage(),
        name: 'default page',
      )
      ..addScenario(
        widget: const FlutterDemoPage(),
        name: 'tap once',
        onCreate: (scenarioWidgetKey) async {
          final finder = find.descendant(
            of: find.byKey(scenarioWidgetKey),
            matching: find.byIcon(Icons.add),
          );
          expect(finder, findsOneWidget);
          await tester.tap(finder);
        },
      )
      ..addScenario(
        widget: const FlutterDemoPage(),
        name: 'tap five times',
        onCreate: (scenarioWidgetKey) async {
          final finder = find.descendant(
            of: find.byKey(scenarioWidgetKey),
            matching: find.byIcon(Icons.add),
          );
          expect(finder, findsOneWidget);

          await tester.tap(finder);
          await tester.tap(finder);
          await tester.tap(finder);
          await tester.tap(finder);
          await tester.tap(finder);
        },
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'flutter_demo_page_multiple_scenarios');
  });
}
