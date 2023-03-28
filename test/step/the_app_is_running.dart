import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_test_first_demo/FlutterDemoPage.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: FlutterDemoPage(),
    ),
  );
}
