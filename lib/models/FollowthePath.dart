import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: PathDrawingGame(),
    debugShowCheckedModeBanner: false,
  ));
}

class PathDrawingGame extends StatefulWidget {
  const PathDrawingGame({super.key});

  @override
  PathDrawingGameState createState() => PathDrawingGameState();
}

class PathDrawingGameState extends State<PathDrawingGame> {
  List<Offset> _points = [];
  final List<Offset> _pathPoints = [];
  bool _isDrawing = false;
  bool _gameOver = false;
  bool _success = false;
  bool _gameCompleted = false;
  final double _tolerance = 20.0;
  int _level = 1;
  double _score = 0;
  int _timeElapsed = 0;
  List<double> _levelAccuracies = [0, 0, 0]; // Stores accuracy for each level
  int _completedPaths = 0;
  int _mistakes = 0;
  Timer? _timer;
  double _pathWidth = 300;
  double _pathHeight = 200;
  Offset _pathOffset = Offset.zero;

  // Get average accuracy across all levels
  double get _averageAccuracy {
    if (_levelAccuracies.every((a) => a == 0)) return 0;
    return _levelAccuracies.where((a) => a > 0).reduce((a, b) => a + b) /
        _levelAccuracies.where((a) => a > 0).length;
  }

  @override
  void initState() {
    super.initState();
    _createPath();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeElapsed++;
      });
    });
  }

  void _createPath() {
    _pathPoints.clear();
    _pathOffset = const Offset(50, 100);

    switch (_level) {
      case 1:
        for (double x = 0; x < _pathWidth; x += 5) {
          double y = _pathHeight / 2 + 50 * sin(x * 0.05);
          _pathPoints.add(_pathOffset + Offset(x, y));
        }
        break;
      case 2:
        for (double x = 0; x < _pathWidth; x += 2) {
          double period = 100;
          double amplitude = 50;
          double t = (x % period) / period;
          double y;

          if (t < 0.25) {
            y = -1 + 8 * t;
          } else if (t < 0.75) {
            y = 1;
          } else {
            y = 1 - 8 * (t - 0.75);
          }

          y = _pathHeight / 2 + amplitude * y;
          _pathPoints.add(_pathOffset + Offset(x, y));
        }
        break;
      case 3:
        for (double x = 0; x < _pathWidth; x += 5) {
          double y = _pathHeight / 2 + 30 * sin(x * 0.05) + 20 * sin(x * 0.1);
          _pathPoints.add(_pathOffset + Offset(x, y));
        }
        break;
    }
  }

  bool _isWithinBoundary(Offset point) {
    for (Offset pathPoint in _pathPoints) {
      if ((point - pathPoint).distance <= _tolerance) {
        return true;
      }
    }
    return false;
  }

  double _calculateAccuracy() {
    if (_points.isEmpty || _pathPoints.isEmpty) return 0;

    int correctPoints = 0;
    for (Offset point in _points) {
      if (_isWithinBoundary(point)) {
        correctPoints++;
      }
    }
    return correctPoints / _points.length;
  }

  void _checkSuccess() {
    double currentAccuracy = _calculateAccuracy();

    if (currentAccuracy >= 0.7) {
      setState(() {
        _levelAccuracies[_level - 1] = currentAccuracy;
        _success = true;
        _gameOver = true;
        _completedPaths++;
        _score += (100 * _level * currentAccuracy).round();

        if (_level == 3) {
          _gameCompleted = true;
        }
      });
    } else {
      setState(() {
        _success = false;
        _gameOver = true;
        _mistakes++;
        _score = max(0, _score - 50);
      });
    }
  }

  void _resetGame() {
    setState(() {
      _points.clear();
      _gameOver = false;
      _success = false;
      _gameCompleted = false;
      _level = 1;
      _levelAccuracies = [0, 0, 0];
      _createPath();
      _score = 0;
      _timeElapsed = 0;
      _completedPaths = 0;
      _mistakes = 0;
    });
    _startTimer();
  }

  void _nextLevel() {
    if (_level < 3) {
      setState(() {
        _level++;
        _points.clear();
        _gameOver = false;
        _success = false;
        _createPath();
      });
    }
  }

  void _showGameStats() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game ${_gameCompleted ? 'Completed!' : 'Over!'}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatRow('Level', '$_level/3'),
              _buildStatRow('Score', _score.toString()),
              _buildStatRow('Time', '$_timeElapsed seconds'),
              if (_gameCompleted) ...[
                _buildStatRow('Level 1 Accuracy',
                    '${(_levelAccuracies[0] * 100).toStringAsFixed(1)}%'),
                _buildStatRow('Level 2 Accuracy',
                    '${(_levelAccuracies[1] * 100).toStringAsFixed(1)}%'),
                _buildStatRow('Level 3 Accuracy',
                    '${(_levelAccuracies[2] * 100).toStringAsFixed(1)}%'),
                _buildStatRow('Average Accuracy',
                    '${(_averageAccuracy * 100).toStringAsFixed(1)}%'),
              ] else
                _buildStatRow('Current Accuracy',
                    '${(_levelAccuracies[_level - 1] * 100).toStringAsFixed(1)}%'),
              _buildStatRow('Completed Paths', _completedPaths.toString()),
              _buildStatRow('Mistakes', _mistakes.toString()),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Main Menu'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (_gameCompleted) {
                  _resetGame();
                } else if (_success) {
                  _nextLevel();
                } else {
                  setState(() {
                    _points.clear();
                    _gameOver = false;
                  });
                }
              },
              child: Text(_gameCompleted
                  ? 'Play Again'
                  : (_success ? 'Next Level' : 'Try Again')),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Follow the Path - Level $_level'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: Text('Score: ${_score.round()}')),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Time', style: TextStyle(fontSize: 16)),
                    Text('$_timeElapsed',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Accuracy', style: TextStyle(fontSize: 16)),
                    Text(
                        '${((_level > 0 && _level <= 3 ? _levelAccuracies[_level - 1] : 0) * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                if (!_gameOver) {
                  setState(() {
                    _points = [details.localPosition];
                    _isDrawing = true;
                    if (!_isWithinBoundary(details.localPosition)) {
                      _gameOver = true;
                      _mistakes++;
                    }
                  });
                }
              },
              onPanUpdate: (details) {
                if (_isDrawing && !_gameOver) {
                  setState(() {
                    _points.add(details.localPosition);
                    if (!_isWithinBoundary(details.localPosition)) {
                      _gameOver = true;
                      _mistakes++;
                    }
                  });
                }
              },
              onPanEnd: (details) {
                _isDrawing = false;
                if (!_gameOver) {
                  _checkSuccess();
                }
                if (_gameOver) {
                  _showGameStats();
                }
              },
              child: CustomPaint(
                painter: PathPainter(
                  points: _points,
                  pathPoints: _pathPoints,
                  gameOver: _gameOver,
                  success: _success,
                ),
                size: Size.infinite,
              ),
            ),
          ),
          if (_gameOver)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    _success ? 'Success!' : 'Try Again',
                    style: TextStyle(
                      fontSize: 24,
                      color: _success ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _resetGame,
                        child: const Text('Restart'),
                      ),
                      if (_success && !_gameCompleted)
                        ElevatedButton(
                          onPressed: _nextLevel,
                          child: const Text('Next Level'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final List<Offset> points;
  final List<Offset> pathPoints;
  final bool gameOver;
  final bool success;

  const PathPainter({
    required this.points,
    required this.pathPoints,
    required this.gameOver,
    required this.success,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final pathPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 40
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (pathPoints.isNotEmpty) {
      final path = Path()..moveTo(pathPoints[0].dx, pathPoints[0].dy);
      for (int i = 1; i < pathPoints.length; i++) {
        path.lineTo(pathPoints[i].dx, pathPoints[i].dy);
      }
      canvas.drawPath(path, pathPaint);
    }

    if (points.isNotEmpty) {
      final paint = Paint()
        ..color = gameOver ? (success ? Colors.green : Colors.red) : Colors.blue
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final userPath = Path()..moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length; i++) {
        userPath.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(userPath, paint);
    }
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;
}
