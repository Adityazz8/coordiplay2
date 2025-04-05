/*import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choose App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppSelectionScreen(),
    );
  }
}

class AppSelectionScreen extends StatelessWidget {
  const AppSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose an App'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('App 1'),
            subtitle: Text('Description of App 1'),
            leading: Icon(Icons.apps),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => App1Screen()),
              );
            },
          ),
          ListTile(
            title: Text('App 2'),
            subtitle: Text('Description of App 2'),
            leading: Icon(Icons.apps),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => App2Screen()),
              );
            },
          ),
          ListTile(
            title: Text('App 3'),
            subtitle: Text('Description of App 3'),
            leading: Icon(Icons.apps),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => App3Screen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class App1Screen extends StatelessWidget {
  const App1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App 1'),
      ),
      body: Center(
        child: Text('Welcome to App 1!'),
      ),
    );
  }
}

class App2Screen extends StatelessWidget {
  const App2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App 2'),
      ),
      body: Center(
        child: Text('Welcome to App 2!'),
      ),
    );
  }
}

class App3Screen extends StatelessWidget {
  const App3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App 3'),
      ),
      body: Center(
        child: Text('Welcome to App 3!'),
      ),
    );
  }
}
*/
