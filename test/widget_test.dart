// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ataxia_project/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(FlutterApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

void runFlutterApp() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  final ValueNotifier<bool> _dark = ValueNotifier<bool>(true);
  final ValueNotifier<double> _widthFactor = ValueNotifier<double>(1.0);

  FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ValueListenableBuilder<bool>(
        valueListenable: _dark,
        builder: (context, color, child) {
          return ValueListenableBuilder<double>(
            valueListenable: _widthFactor,
            builder: (context, factor, child) {
              return Scaffold(
                backgroundColor: _dark.value ? Colors.black : Colors.white,
                appBar: AppBar(
                  actions: [
                    Switch(
                      value: _dark.value,
                      onChanged: (value) {
                        _dark.value = value;
                      },
                    ),
                    DropdownButton<double>(
                      value: _widthFactor.value,
                      onChanged: (value) {
                        _widthFactor.value = value!;
                      },
                      items: [
                        DropdownMenuItem<double>(
                          value: 0.5,
                          child: Text('Size: 50%'),
                        ),
                        DropdownMenuItem<double>(
                          value: 0.75,
                          child: Text('Size: 75%'),
                        ),
                        DropdownMenuItem<double>(
                          value: 1.0,
                          child: Text('Size: 100%'),
                        ),
                      ],
                    ),
                  ],
                ),
                body: Center(
                  child: SizedBox(
                    width:
                        MediaQuery.of(context).size.width * _widthFactor.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Group1244831159()],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Group1244831159 extends StatelessWidget {
  const Group1244831159({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 500,
          height: 530,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 500,
                  height: 120,
                  decoration: BoxDecoration(color: Color(0xFF2979FF)),
                ),
              ),
              Positioned(
                left: 51,
                top: 170,
                child: Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(color: Color(0xFF00E8F1)),
                ),
              ),
              Positioned(
                left: 51,
                top: 300,
                child: Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(color: Color(0xFF00E8F1)),
                ),
              ),
              Positioned(
                left: 49,
                top: 430,
                child: Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(color: Color(0xFF00E8F1)),
                ),
              ),
              Positioned(
                left: 179,
                top: 22,
                child: Text(
                  'PLAY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Roboto',
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 182,
                top: 192,
                child: Text(
                  'STATS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Roboto',
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 154,
                top: 322,
                child: Text(
                  'OPTIONS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Roboto',
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 195,
                top: 452,
                child: Text(
                  'HELP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Roboto',
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
