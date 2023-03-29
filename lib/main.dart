import 'package:flutter/material.dart';
import 'package:golden_test_first_demo/FlutterDemoPage.dart';
import 'package:golden_test_first_demo/WeatherForecast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NewMyApp());
  }
}

class NewMyApp extends StatefulWidget {
  const NewMyApp({super.key});

  @override
  State<NewMyApp> createState() => _NewMyAppState();
}

class _NewMyAppState extends State<NewMyApp> {
  @override
  Widget build(BuildContext cntx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goldent flutter test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  cntx,
                  MaterialPageRoute(
                    builder: (cntx) => const FlutterDemoPage(),
                  ),
                );
              },
              child: const Text('normal test'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(cntx, MaterialPageRoute(
                  builder: (cntx) {
                    return const WeatherCard(temp: 66, weather: Weather.sunny);
                  },
                ));
              },
              child: const Text('Weather Test'),
            )
          ],
        ),
      ),
    );
  }
}
