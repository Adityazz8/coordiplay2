import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(PrecisionSliderGame());
}

class PrecisionSliderGame extends StatelessWidget {
  const PrecisionSliderGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precision Slider Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SliderGameScreen(),
    );
  }
}

class SliderGameScreen extends StatefulWidget {
  const SliderGameScreen({super.key});

  @override
  _SliderGameScreenState createState() => _SliderGameScreenState();
}

class _SliderGameScreenState extends State<SliderGameScreen> {
  double _sliderValue = 0.0;
  double _targetValue = 50.0; // Initial target value
  int _score = 0;
  int _level = 1;
  double _targetRange =
      10.0; // Initial target range (e.g., ±5 around the target)

  void _updateScore() {
    double difference = (_sliderValue - _targetValue).abs();
    if (difference <= _targetRange / 2) {
      _score = 100 -
          (difference * (100 / (_targetRange / 2)))
              .toInt(); // Higher score for closer values
    } else {
      _score = 0;
    }

    // Haptic feedback if far from the target
    if (difference > _targetRange) {
      HapticFeedback.vibrate();
    }
  }

  void _nextLevel() {
    setState(() {
      _level++;
      _targetValue = (0.0 + 100.0 * _level) /
          (_level + 1); // Randomize target for next level
      _targetRange =
          10.0 / _level; // Decrease target range for increased difficulty
      _sliderValue = 0.0; // Reset slider value
      _score = 0; // Reset score
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Precision Slider Game - Level $_level'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Target: ${_targetValue.toStringAsFixed(1)} ± ${(_targetRange / 2).toStringAsFixed(1)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Slider(
              value: _sliderValue,
              min: 0.0,
              max: 100.0,
              divisions: 100,
              label: _sliderValue.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                  _updateScore();
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Your Value: ${_sliderValue.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Score: $_score',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (_score >=
                90) // Only show "Next Level" button if score is high enough
              ElevatedButton(
                onPressed: _nextLevel,
                child: Text('Next Level'),
              ),
          ],
        ),
      ),
    );
  }
}
