import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Первая страница')),
      body: Center(
        child: Column(
          children: [
            Icon(Icons.fitness_center_outlined),
            SizedBox(height: 8),
            Text('Это первая страница!'),
          ],
        ),
      ),
    );
  }
}
