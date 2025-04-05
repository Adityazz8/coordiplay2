import 'package:ataxia_project/models/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:ataxia_project/models/DragandDrop.dart';
import 'package:ataxia_project/models/Taptheglow.dart';
import 'package:ataxia_project/models/followthepath.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<bool> _darkMode = ValueNotifier<bool>(true);
  final ValueNotifier<double> _widthFactor = ValueNotifier<double>(1.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValueListenableBuilder<bool>(
        valueListenable: _darkMode,
        builder: (context, isDark, child) {
          return ValueListenableBuilder<double>(
            valueListenable: _widthFactor,
            builder: (context, factor, child) {
              return Scaffold(
                /*  backgroundColor: isDark ? Colors.black : Colors.white,
                appBar: AppBar(
                  title: Text('CoOrdiPlay'),
                  actions: [
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        _darkMode.value = value;
                      },
                    ),
                    DropdownButton<double>(
                      value: factor,
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
              */
                body: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * factor,
                    child: GameSelectionScreen(),
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

class GameSelectionScreen extends StatelessWidget {
  const GameSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDEAFF), Color(0xFFDE9EFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with profile icon and hamburger
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    Icon(Icons.menu, color: Colors.black),
                  ],
                ),
              ),

              // Logo & Title
              Column(
                children: [
                  const Text(
                    'CoOrdiPlay',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5A007F),
                      fontFamily: 'Amaranth',
                    ),
                  ),
                  const SizedBox(height: 60),
                  // App Logo or Icon
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.asset(
                      'lib/assests/ataxialogo1.png', // Make sure to add your logo asset
                      height: 120,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.games,
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Game Buttons Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildGameTile(
                        context,
                        'Tap The Glow',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AtaxiaGameApp()),
                        ),
                      ),
                      _buildGameTile(
                        context,
                        'Drag And Drop',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DragDropGame()),
                        ),
                      ),
                      _buildGameTile(
                        context,
                        'Follow The Path',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PathDrawingGame()),
                        ),
                      ),
                      _buildGameTile(
                        context,
                        'Dashboard',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Dashboard()),
                        ), // Add navigation if needed
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _bottomNavButton('ABOUT', Icons.info),
                    _bottomNavButton('LEARN', Icons.school),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameTile(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFFBE3FF), Color(0xFFE190EC), Color(0xFFC73ED9)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Amaranth',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _bottomNavButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFBBA5F5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
