import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Третья страница')),
      body: Center(
        child: Column(
          children: [
            Icon(Icons.sports_football),
            SizedBox(height: 8),
            Text('Это третья страница!'),
          ],
        ),
      ),
    );
  }
}
