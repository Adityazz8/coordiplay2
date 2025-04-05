import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    context,
                    title: 'User Analysis',
                    icon: Icons.analytics,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnalysisPage(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: 'Reports',
                    icon: Icons.report,
                    onTap: () {
                      // Add navigation or functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalysisPage extends StatelessWidget {
  // Sample user data for the table
  final List<Map<String, dynamic>> userData = [
    {
      'name': 'John Doe',
      'age': 32,
      'game': 'Tap The Glow',
      'score': 85,
      'date': '2023-05-15'
    },
    {
      'name': 'John Doe',
      'age': 32,
      'game': 'Drag And Drop',
      'score': 92,
      'date': '2023-05-16'
    },
    {
      'name': 'John Doe',
      'age': 32,
      'game': 'Follow The Path',
      'score': 78,
      'date': '2023-05-17'
    },
    {
      'name': 'John Doe',
      'age': 32,
      'game': 'Tap The Glow',
      'score': 88,
      'date': '2023-05-18'
    },
    {
      'name': 'John Doe',
      'age': 32,
      'game': 'Drag And Drop',
      'score': 95,
      'date': '2023-05-19'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(
                  label: Text('Name',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Age',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Game',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Score',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  numeric: true),
              DataColumn(
                  label: Text('Date',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: userData.map((user) {
              return DataRow(
                cells: [
                  DataCell(Text(user['name'])),
                  DataCell(Text(user['age'].toString())),
                  DataCell(Text(user['game'])),
                  DataCell(Text(user['score'].toString())),
                  DataCell(Text(user['date'])),
                ],
              );
            }).toList(),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            headingRowColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            dataRowColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
