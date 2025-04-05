/*
import 'package:flutter/material.dart'; // UI components  fdb gr f jh
import 'dart:async';
import 'dart:math';

void main() => runApp(BalanceMaster());

class BalanceMaster extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
      );
}

// StartScreen
class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => GameScreen()),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: TextStyle(fontSize: 24),
            ),
            child: Text('Start Game'),
          ),
        ),
      );
}

// GameScreen
class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double ballX = 0.0, ballY = 0.0;
  double ringRadius = 100;
  double ballRadius = 20;
  int timeInsideRing = 0;
  late Timer timer;
  bool isInsideRing = false;

  void checkBallInsideRing() {
    double distance = sqrt(pow(ballX, 2) + pow(ballY, 2));
    if (distance + ballRadius < ringRadius) {
      isInsideRing = true;
    } else {
      isInsideRing = false;
      timer.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => GameOverScreen(timeInsideRing)),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Stack(
          children: [
            Container(
              width: ringRadius * 2,
              height: ringRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
            Positioned(
              left: ballX + ringRadius - ballRadius,
              top: ballY + ringRadius - ballRadius,
              child: Container(
                width: ballRadius * 2,
                height: ballRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// GameOverScreen
class GameOverScreen extends StatelessWidget {
  final int timeInsideRing;
  GameOverScreen(this.timeInsideRing);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("!!! Game Over !!!",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              SizedBox(height: 20),
              Text("Time Ball Stayed Inside Ring: $timeInsideRing seconds",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => StartScreen())),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: TextStyle(fontSize: 24),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: Text("Play Again"),
              ),
            ],
          ),
        ),
      );
}
*/
