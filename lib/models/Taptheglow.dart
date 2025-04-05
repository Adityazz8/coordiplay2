import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';

void main() {
  runApp(AtaxiaGameApp());
}

class AtaxiaGameApp extends StatelessWidget {
  const AtaxiaGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 216, 251),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CountdownScreen()),
            );
          },
          child: Text('Start Game', style: TextStyle(fontSize: 34)),
        ),
      ),
    );
  }
}

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int countdown = 3;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 1) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AtaxiaGameScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 216, 251),
      body: Center(
        child: Text(
          '$countdown',
          style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AtaxiaGameScreen extends StatefulWidget {
  const AtaxiaGameScreen({super.key});

  @override
  _AtaxiaGameScreenState createState() => _AtaxiaGameScreenState();
}

class _AtaxiaGameScreenState extends State<AtaxiaGameScreen> {
  final int gridSize = 3;
  int glowingSquareIndex = 0;
  int correctTaps = 0;
  int wrongTaps = 0;
  bool isGameActive = true;
  List<Color> squareColors = [];
  Timer? gameTimer;
  int remainingTime = 30;
  Random random = Random();
  int score = 0;
  int timeElapsed = 0;
  int successfulTaps = 0;
  int failedTaps = 0;
  int totalTaps = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _initializeSquares();
    _setNewGlowingSquare();
    _startGameTimer();
    startGame();
  }

  void _initializeSquares() {
    squareColors = List<Color>.filled(gridSize * gridSize, Colors.grey);
  }

  void _startGameTimer() {
    gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        setState(() {
          isGameActive = false;
        });
        gameTimer?.cancel();
        _showGameOverScreen();
      }
    });
  }

  void _setNewGlowingSquare() {
    setState(() {
      glowingSquareIndex = random.nextInt(gridSize * gridSize);
      squareColors = List<Color>.filled(gridSize * gridSize, Colors.grey);
      squareColors[glowingSquareIndex] = Colors.green;
    });
  }

  void _handleTap(int index) {
    if (!isGameActive) return;

    if (index == glowingSquareIndex) {
      HapticFeedback.lightImpact();
      setState(() {
        correctTaps++;
        successfulTaps++;
        score += 10;
      });
      Timer(Duration(milliseconds: 200), () {
        _setNewGlowingSquare();
      });
    } else {
      HapticFeedback.heavyImpact();
      setState(() {
        wrongTaps++;
        failedTaps++;
        score -= 5;
        squareColors[index] = Colors.red;
      });
      Timer(Duration(milliseconds: 250), () {
        setState(() {
          squareColors[index] = Colors.grey;
        });
      });
    }
    totalTaps++;
  }

  void _showGameOverScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          correctTaps: correctTaps,
          wrongTaps: wrongTaps,
          score: score,
          timeElapsed: 30 - remainingTime,
        ),
      ),
    );
  }

  void startGame() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeElapsed++;
      });
    });
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoOrdiPlay'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Correct: $correctTaps',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Text('Wrong: $wrongTaps',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Text('Time: $remainingTime',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _handleTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: squareColors[index],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    timer?.cancel();
    super.dispose();
  }
}

class GameOverScreen extends StatelessWidget {
  final int correctTaps;
  final int wrongTaps;
  final int score;
  final int timeElapsed;

  const GameOverScreen({
    super.key,
    required this.correctTaps,
    required this.wrongTaps,
    required this.score,
    required this.timeElapsed,
  });

  @override
  Widget build(BuildContext context) {
    double accuracy = correctTaps + wrongTaps > 0
        ? (correctTaps / (correctTaps + wrongTaps) * 100)
        : 0;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 216, 251),
      appBar: AppBar(
        title: Text('CoOrdiPlay'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Game Over!',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Score: $score', style: TextStyle(fontSize: 24)),
            Text('Time: $timeElapsed seconds', style: TextStyle(fontSize: 24)),
            Text('Correct Taps: $correctTaps', style: TextStyle(fontSize: 24)),
            Text('Wrong Taps: $wrongTaps', style: TextStyle(fontSize: 24)),
            Text('Accuracy: ${accuracy.toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AtaxiaGameScreen()),
                );
              },
              child: Text('Play Again', style: TextStyle(fontSize: 24)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StartScreen()),
                );
              },
              child: Text('Main Menu', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}
