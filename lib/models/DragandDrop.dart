import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(DragDropGame());
}

class DragDropGame extends StatelessWidget {
  const DragDropGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DragDropGameScreen(),
    );
  }
}

class DragDropGameScreen extends StatefulWidget {
  const DragDropGameScreen({super.key});

  @override
  DragDropGameScreenState createState() => DragDropGameScreenState();
}

class DragDropGameScreenState extends State<DragDropGameScreen>
    with TickerProviderStateMixin {
  int currentLevel = 1;
  bool isCompleted = false;
  Map<String, bool> placedPieces = {};
  int score = 0;
  int timeElapsed = 0;
  int successfulDrops = 0;
  int failedDrops = 0;
  int totalAttempts = 0;
  Timer? timer;
  List<AnimationController> animationControllers = [];

  // Puzzle levels with improved visual distinction
  List<List<PuzzlePiece>> puzzleLevels = [
    // Level 1: Basic (2 pieces)
    [
      PuzzlePiece(label: 'A', color: Colors.red[400]!),
      PuzzlePiece(label: 'B', color: Colors.blue[400]!),
    ],
    // Level 2: Medium (4 pieces)
    [
      PuzzlePiece(label: 'A', color: Colors.red[400]!),
      PuzzlePiece(label: 'B', color: Colors.blue[400]!),
      PuzzlePiece(label: 'C', color: Colors.green[400]!),
      PuzzlePiece(label: 'D', color: Colors.orange[400]!),
    ],
    // Level 3: Hard (6 pieces)
    [
      PuzzlePiece(label: 'A', color: Colors.red[400]!),
      PuzzlePiece(label: 'B', color: Colors.blue[400]!),
      PuzzlePiece(label: 'C', color: Colors.green[400]!),
      PuzzlePiece(label: 'D', color: Colors.orange[400]!),
      PuzzlePiece(label: 'E', color: Colors.purple[400]!),
      PuzzlePiece(label: 'F', color: Colors.teal[400]!),
    ],
    // Level 4: Challenge (8 moving pieces)
    [
      PuzzlePiece(label: 'A', color: Colors.red[400]!),
      PuzzlePiece(label: 'B', color: Colors.blue[400]!),
      PuzzlePiece(label: 'C', color: Colors.green[400]!),
      PuzzlePiece(label: 'D', color: Colors.orange[400]!),
      PuzzlePiece(label: 'E', color: Colors.purple[400]!),
      PuzzlePiece(label: 'F', color: Colors.teal[400]!),
      PuzzlePiece(label: 'G', color: Colors.pink[400]!),
      PuzzlePiece(label: 'H', color: Colors.brown[400]!),
    ],
  ];

  @override
  void initState() {
    super.initState();
    startGame();
  }

  List<PuzzlePiece> get currentPuzzlePieces {
    return List<PuzzlePiece>.from(puzzleLevels[currentLevel - 1]);
  }

  void checkCompletion() {
    if (placedPieces.length == puzzleLevels[currentLevel - 1].length &&
        placedPieces.values.every((placed) => placed)) {
      setState(() {
        isCompleted = true;
        score += (currentLevel * 50); // Bonus points for completing level
      });

      Future.delayed(Duration(seconds: 1), () {
        if (currentLevel < puzzleLevels.length) {
          nextLevel();
        } else {
          _showCompletionDialog();
        }
      });
    }
  }

  void nextLevel() {
    // Clear all animations before moving to next level
    for (var controller in animationControllers) {
      controller.dispose();
    }
    animationControllers.clear();

    setState(() {
      currentLevel++;
      placedPieces.clear();
      isCompleted = false;
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('🎉 Game Completed!', style: TextStyle(fontSize: 24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Congratulations! You completed all levels.'),
              SizedBox(height: 16),
              _buildStatRow('Final Score', score.toString()),
              _buildStatRow('Time', '$timeElapsed seconds'),
              _buildStatRow('Accuracy',
                  '${(successfulDrops / totalAttempts * 100).toStringAsFixed(1)}%'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Play Again', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  void startGame() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeElapsed++;
      });
    });
  }

  void resetGame() {
    // Clear all animations
    for (var controller in animationControllers) {
      controller.dispose();
    }
    animationControllers.clear();

    setState(() {
      currentLevel = 1;
      placedPieces.clear();
      isCompleted = false;
      score = 0;
      timeElapsed = 0;
      successfulDrops = 0;
      failedDrops = 0;
      totalAttempts = 0;
    });
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 241, 220, 187),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Drag & Drop Game',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 21, 54)),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 185, 163, 126),
        ),
        body: Stack(
          children: [
            if (isCompleted)
              Center(
                child: Text(
                  "🎉 Level $currentLevel Completed!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              )
            else
              Column(
                children: [
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Level", style: TextStyle(fontSize: 18)),
                            Text("$currentLevel/${puzzleLevels.length}",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Score", style: TextStyle(fontSize: 18)),
                            Text("$score",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Time", style: TextStyle(fontSize: 18)),
                            Text("$timeElapsed",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: currentLevel == 4
                        ? _buildLevel4DropBoxes()
                        : _buildStandardDropBoxes(),
                  ),
                  SizedBox(height: 16),
                  _buildDraggablePieces(),
                  SizedBox(height: 16),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardDropBoxes() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: currentPuzzlePieces.map((piece) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: DragTarget<PuzzlePiece>(
              builder: (context, candidateData, rejectedData) {
                return _buildStaticBox(piece);
              },
              onAccept: (data) {
                handleDrop(data, piece);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLevel4DropBoxes() {
    return GridView.count(
      crossAxisCount: 4,
      padding: EdgeInsets.all(16),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: currentPuzzlePieces.map((piece) {
        return _buildAnimatedBox(piece);
      }).toList(),
    );
  }

  Widget _buildAnimatedBox(PuzzlePiece piece) {
    final index = currentPuzzlePieces.indexOf(piece);
    final controller = AnimationController(
      duration: Duration(seconds: [5, 7, 6, 8, 9, 5, 6, 7][index % 8]),
      vsync: this,
    );
    animationControllers.add(controller);

    final animation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.repeat();

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final scale = 30.0;
        // Different movement patterns for each box
        final x = scale * sin(animation.value + index * pi / 4);
        final y = scale * cos(animation.value * 1.5 + index * pi / 3);

        return Transform.translate(
          offset: Offset(x, y),
          child: DragTarget<PuzzlePiece>(
            builder: (context, candidateData, rejectedData) {
              return _buildStaticBox(piece);
            },
            onAccept: (data) {
              handleDrop(data, piece);
            },
          ),
        );
      },
    );
  }

  Widget _buildStaticBox(PuzzlePiece piece) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              placedPieces[piece.label] == true ? Colors.green : Colors.black,
          width: 2,
        ),
        color: placedPieces[piece.label] == true
            ? piece.color.withAlpha(150)
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          piece.label,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color:
                placedPieces[piece.label] == true ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDraggablePieces() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: currentPuzzlePieces.map((piece) {
        return Draggable<PuzzlePiece>(
          data: piece,
          feedback: _buildPieceWidget(piece, isDragging: true),
          childWhenDragging: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: placedPieces[piece.label] == true
              ? SizedBox(width: 70, height: 70)
              : _buildPieceWidget(piece),
        );
      }).toList(),
    );
  }

  Widget _buildPieceWidget(PuzzlePiece piece, {bool isDragging = false}) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: piece.color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Center(
        child: Text(
          piece.label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void handleDrop(PuzzlePiece data, PuzzlePiece target) {
    totalAttempts++;
    if (data.label == target.label) {
      setState(() {
        placedPieces[data.label] = true;
        successfulDrops++;
        score += 10 * currentLevel; // More points for higher levels
      });
      checkCompletion();
    } else {
      setState(() {
        failedDrops++;
        score = max(0, score - 5); // Don't go below 0
      });
    }
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var controller in animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class PuzzlePiece {
  final String label;
  final Color color;

  PuzzlePiece({required this.label, required this.color});
}
